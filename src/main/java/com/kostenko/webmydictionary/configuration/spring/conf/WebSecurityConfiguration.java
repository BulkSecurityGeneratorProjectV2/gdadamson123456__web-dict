package com.kostenko.webmydictionary.configuration.spring.conf;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;

import static com.google.common.base.Preconditions.checkNotNull;

@Configuration
@EnableWebSecurity
public class WebSecurityConfiguration extends WebSecurityConfigurerAdapter {
    private final UserDetailsService userDetailsService;

    @Autowired
    public WebSecurityConfiguration(UserDetailsService userDetailsServiceImpl) {
        checkNotNull(userDetailsServiceImpl, "UserDetailService can't be null");
        this.userDetailsService = userDetailsServiceImpl;
    }

    @Autowired
    public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
        checkNotNull(auth, "AuthenticationManagerBuilder can't be null");
        auth.userDetailsService(userDetailsService);
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.authorizeRequests()
                .antMatchers("/admin/**").access("hasRole('ROLE_admin')")
                .antMatchers("/user/**").access("hasAnyRole('ROLE_user', 'ROLE_admin')")
                .and().formLogin()
                .defaultSuccessUrl("/")
                .failureForwardUrl("/log?error")
                .usernameParameter("username")
                .passwordParameter("password");
    }

    @Override
    public UserDetailsService userDetailsServiceBean() throws Exception {
        return userDetailsService;
    }
}
