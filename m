Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=BAYES_40,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD2BC433F5
	for <linux-hardening@archiver.kernel.org>; Sun,  5 Sep 2021 09:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62BB060F12
	for <linux-hardening@archiver.kernel.org>; Sun,  5 Sep 2021 09:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235749AbhIEJuN (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 5 Sep 2021 05:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbhIEJuM (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 5 Sep 2021 05:50:12 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CF5C061575
        for <linux-hardening@vger.kernel.org>; Sun,  5 Sep 2021 02:49:05 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id q70so7364761ybg.11
        for <linux-hardening@vger.kernel.org>; Sun, 05 Sep 2021 02:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=AQI+gaP3gRr3DWEJsbHrkGhbGs7Zx+5Z3tcCL1B09EM=;
        b=N0HH1/cu3QWh+3njUp8JC/KM9BTpPcb4WqrYOrByJcCloli3M2aRc5RmMdjN9xowYQ
         b+Dqyn9KheIRrTkwRMkAI9zWSSX5AA4P7R1XMgfMJOBlNVppSE23bXixqAwpLiRQlJWv
         IQjLK020hGDyNh40hUryBUeDtrSYDDevnL5ffAscKiSd831sDT6lohhyIUh4YuabXUmN
         5/2lHLCK8YuYyCOVzwevZ/nF9mvtdppOZeszHfXZrGKu0z2g+NVqad2r4vFtrkeap8Fr
         oziMRG8IX3uITR5wwXETjDu/ayOO1eFB074qhshsYw5oERro5q9PAB5+VlPYuSSGqYck
         UPmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=AQI+gaP3gRr3DWEJsbHrkGhbGs7Zx+5Z3tcCL1B09EM=;
        b=HPjNeWq6BRMR7JwjmEB9a2xLlI9sv6U6hF/UUSNf25/BhnYL75GFEDZkcVPlhRH2Kv
         kROuznx0dn/xoPMH5cpMn1k49QF5ZY5oU5d4/KbrOK8rGR4kotxZf8awqYZfY7KcbPHc
         TTza0rCWGWXWbunHguiydKYUM49leJ3pMjiLlKKCcMrcPHWb4oVnYLAEJOGjp5KXkLVI
         tOXZDCIT6aoICKTkeEhV1bmU5TMa05Ml18gM+x52w6jdwlvfnY9/p2scQjAMuX3T7yJL
         R3UrPSN9uTgVi1ovEcSZnQ3RGXs4jpTiqinBNrpi2jkd9hkJayCty1Mh6Z06AigiZZvh
         5TMQ==
X-Gm-Message-State: AOAM533KWPd/JcF2wjWAoO9g0rjdiHXyOk2Y7S5OeznJnp1zFDIQUY/j
        C+pM5tZHt3FxtRuuKQfsIgKSQYKm93hzaN3vP5PQUlwtQ8XctQ==
X-Google-Smtp-Source: ABdhPJyNm2OriKCmYlSWhW2lNBd8jG3IepYpN7hf4Pz91LAR391GRz0w6YZkeHBTZsI1qB9vrC9B2qsS07JsOEgE+eQ=
X-Received: by 2002:a25:5086:: with SMTP id e128mr9285880ybb.89.1630835344617;
 Sun, 05 Sep 2021 02:49:04 -0700 (PDT)
MIME-Version: 1.0
From:   Turritopsis Dohrnii Teo En Ming <ceo.teo.en.ming@gmail.com>
Date:   Sun, 5 Sep 2021 17:48:54 +0800
Message-ID: <CAMEJMGHtdxmX5ayE8g+sHx1QxRdsqkyyPyVAVVk4AvgcfHm9zQ@mail.gmail.com>
Subject: Introduction: I am a Linux and open source software enthusiast
To:     linux-hardening@vger.kernel.org
Cc:     ceo@teo-en-ming-corp.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Subject: Introduction: I am a Linux and open source software enthusiast

Greetings from Singapore,

My name is Mr. Turritopsis Dohrnii Teo En Ming, 43 years old as of 5
September 2021. My country is Singapore. Presently I am an IT
Consultant with a System Integrator (SI)/computer firm in Singapore. I
am also a Linux and open source software and information technology
enthusiast.

You can read my autobiography on my redundant blogs. The title of my
autobiography is:

"Autobiography of Singaporean Targeted Individual Mr. Turritopsis
Dohrnii Teo En Ming (Very First Draft, Lots More to Add in Future)"

Links to my redundant blogs (Blogger and Wordpress) can be found in my
email signature below.

I have three other redundant blogs, namely:

https://teo-en-ming.tumblr.com/

https://teo-en-ming.medium.com/

https://teo-en-ming.livejournal.com/

Future/subsequent versions of my autobiography will be published on my
redundant blogs.

My Blog Books are also available for download on my redundant blogs.

Thank you very much.




-----BEGIN EMAIL SIGNATURE-----

The Gospel for all Targeted Individuals (TIs):

[The New York Times] Microwave Weapons Are Prime Suspect in Ills of
U.S. Embassy Workers

Link:
https://www.nytimes.com/2018/09/01/science/sonic-attack-cuba-microwave.html

********************************************************************************************

Singaporean Targeted Individual Mr. Turritopsis Dohrnii Teo En Ming's
Academic Qualifications as at 14 Feb 2019 and refugee seeking attempts
at the United Nations Refugee Agency Bangkok (21 Mar 2017), in Taiwan
(5 Aug 2019) and Australia (25 Dec 2019 to 9 Jan 2020):

[1] https://tdtemcerts.wordpress.com/

[2] https://tdtemcerts.blogspot.sg/

[3] https://www.scribd.com/user/270125049/Teo-En-Ming

-----END EMAIL SIGNATURE-----
