Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3CBC4332F
	for <linux-hardening@archiver.kernel.org>; Sat, 15 Oct 2022 04:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiJOEQc (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 15 Oct 2022 00:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJOEQb (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 15 Oct 2022 00:16:31 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2740B6A484
        for <linux-hardening@vger.kernel.org>; Fri, 14 Oct 2022 21:16:29 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so9617164pjq.3
        for <linux-hardening@vger.kernel.org>; Fri, 14 Oct 2022 21:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PmdVXdQ9FGhVw1kjKsoHhC7P0YHFdJCMDiY4TmAlh6A=;
        b=XI/pFEb4jatZIH49JKKMBeUqEms7Y+mCoAPbLwk574MiyOV08iPJhaqM39D3WDM1PD
         IwiSkE1jO/+TG90CP6pX4wE3bO6UdOwvSh53l3A8g6RkCGmuPmoaBcI6KZQmbB6gve3q
         cCBjj1xyd657rO8okG35stDJZ97RlzBFtfJIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PmdVXdQ9FGhVw1kjKsoHhC7P0YHFdJCMDiY4TmAlh6A=;
        b=1Jvo3iPXpgNu06oECNRridPOjESfMe4YLb0caCYDAn6C/zc7rqipHFTDCFg+6EalA1
         M5bvDFu/0sfRi8Iho6G3c3mnj7jRZLSs0wqb6t5FleCmBT0Cgfy5Xbap6kAliIJoWbLp
         hb+h30Xte3NsGeWLoZQZKrJ5whT1JWjqqU3ZiX4g5wj4S6VYKnX8HBnM5+xOSpX5cyVx
         Aw0e4c2J/UJ7sFte4E6P+lhcbTwJ5QB4AO6/VtClL6+2JGABRDPx9Tm1d8ax0Co/yHoU
         RGyITtUw2mUPi72D14iXLUdjPuWOCU1q9gP9MZCfpt9Iua90qEOOxwBNlVMz7Czv6DxN
         1Bzw==
X-Gm-Message-State: ACrzQf3eXcrAMUZ4WyzA/hQ+9+CrlkGyVjpLAWos9LlQwxvW9AKehoQV
        hjY1JwDQHAUI30+RIJ0XDPALsv6aUxOb4A==
X-Google-Smtp-Source: AMsMyM7OHlmWqyNuxNgycJNo30GYd1h5NGc4BpXGoGHW1U5AUjFwXyXwLGzudnU9CE3hvmHr7LZl8g==
X-Received: by 2002:a17:902:724a:b0:177:fd96:37bf with SMTP id c10-20020a170902724a00b00177fd9637bfmr948978pll.25.1665807388574;
        Fri, 14 Oct 2022 21:16:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x6-20020a170902ec8600b001755e4278a6sm2428140plg.261.2022.10.14.21.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 21:16:27 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Simon Brand <simon.brand@postadigitale.de>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH 0/2] tty: Allow TIOCSTI to be disabled
Date:   Fri, 14 Oct 2022 21:16:22 -0700
Message-Id: <20221015041352.never.966-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1599; h=from:subject:message-id; bh=iR5V8jk/8mmUSQkSX00bPiVEek52B/UfT7Bj63olC6k=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjSjQYu6itPh6oUgVG0i3EJyhhJjxXE6vzFEb18SRx CKlxVrqJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY0o0GAAKCRCJcvTf3G3AJg5RD/ 0cdXj/S8Ue5HyIJrRbNQiEt5Rniaggu1EB0kSTve2toPnelz1jTA2JSj79sXy5EH9CfQRAj75QROFf R0f/HMdBq1lOf4wdjKxhGON0kW/76V5VUKlSqvigXBgv7z4KAPcl6JDMRhSys7+lyOEjRNy+VJ55K3 BzuH54NPDfForE2lff1F+AWrm5mRB6wXbCOTacTbCt+gE/Rry3EH1tX6yVd+g/LdwU6zav8vCdtovs IZ5rsZOX11WwaNuxrvA3hn9optYVADOr2KPGsrO4WdvCC9H2UMKayu4Xz2z0rhUAFnlfHPaURyTxiL fMt9WpvWTeoPH3VjHNrckBCInFwjK1aGhdTqwNTJSLSAFpaYbOOelJusQI7ax3chuJOl2dm2fToW0g 8pZPsLqDtpMtQ8I5KaMtvzm4Z6fuT/TFGp+2+UYRRBBpZsx3bEr2DyLgxlAmlw7nnAfnZ821XHBPsK urzHmJ4dtSdSKQ2LYA9YFgK9doMdjfseYLhr6lFv+2gGJHu6oRRgOm1L3+RFmY8QY/4sp4GOqOjmXR SbqT/QOfWY0kBcQZO/xBp+DszEHRkp9oRhKM/SZpaj6Ecu4kEPz6Gta5Iq30ut/BRCLYOSuJPHpZfP idNBwZSyP5BG2hdHrK/jhP/R+QssnG9rztPH4fHK/nRlSIPqLTA/zWhM10qA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi,

This is so very long over-due. We just need to do this and put an end
to this legacy operation.

Repeating the commit log from patch 2:

    TIOCSTI continues its long history of being used in privilege escalation
    attacks[1]. Prior attempts to provide a mechanism to disable this have
    devolved into discussions around creating full-blown LSMs to provide
    arbitrary ioctl filtering, which is hugely over-engineered -- only
    TIOCSTI is being used this way. 3 years ago OpenBSD entirely removed
    TIOCSTI[2], Android has had it filtered for longer[3], and the tools that
    had historically used TIOCSTI either do not need it, are not commonly
    built with it, or have had its use removed.

    Provide a simple CONFIG and global sysctl to disable this for the system
    builders who have wanted this functionality for literally decades now,
    much like the ldisc_autoload CONFIG and sysctl.

    [1] https://lore.kernel.org/linux-hardening/Y0m9l52AKmw6Yxi1@hostpad
    [2] https://undeadly.org/cgi?action=article;sid=20170701132619
    [3] https://lore.kernel.org/lkml/CAFJ0LnFGRuEEn1tCLhoki8ZyWrKfktbF+rwwN7WzyC_kBFoQVA@mail.gmail.com/

Thanks,

-Kees

Kees Cook (2):
  tty: Move sysctl setup into "core" tty logic
  tty: Allow TIOCSTI to be disabled

 drivers/tty/Kconfig     | 19 +++++++++++++++++
 drivers/tty/tty.h       |  2 +-
 drivers/tty/tty_io.c    | 47 +++++++++++++++++++++++++++++++++++++++--
 drivers/tty/tty_ldisc.c | 38 +--------------------------------
 4 files changed, 66 insertions(+), 40 deletions(-)

-- 
2.34.1

