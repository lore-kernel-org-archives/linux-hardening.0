Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6512CC4320A
	for <linux-hardening@archiver.kernel.org>; Tue,  3 Aug 2021 19:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52F4F6104F
	for <linux-hardening@archiver.kernel.org>; Tue,  3 Aug 2021 19:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240318AbhHCTqa (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 3 Aug 2021 15:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240302AbhHCTq1 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 3 Aug 2021 15:46:27 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04012C061757
        for <linux-hardening@vger.kernel.org>; Tue,  3 Aug 2021 12:46:16 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id k4-20020a17090a5144b02901731c776526so5401094pjm.4
        for <linux-hardening@vger.kernel.org>; Tue, 03 Aug 2021 12:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3nOLous5BdC2Vwigd/sUxTARBcIKorC+Yem2YG2Kcf8=;
        b=ALpY5IpDWS2MrWYntcIGb9kIypcJpfYpKe/1l+O7Rh1J3Z8RoYbskNmDyWQF5z9zKZ
         hUahgFDcfylZ+MPgVFqc6eMt7hWs46rEdhFhWBHuzcy/Wk1nYPr4N8chNYNwKLByzOqa
         IxQdMMxBo6PyH5C5h2Tjct7UA1sfiXTvCBJi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3nOLous5BdC2Vwigd/sUxTARBcIKorC+Yem2YG2Kcf8=;
        b=ZGSDBbEls9QKg06uM5ULerlmKd26l0MfFhBiqXZHlQlIL23EEn9wg61WVd967DPL3D
         Bj/oU36pnIjfGszw7m0LhvBsNLT+Y0VxYGh3PBuR6o6bfVF+UTxE3ltddFxCUMgzsrQy
         kBlt1MBePbN42KQGf2WIJ6geZk7/iw4m9xBvueRUgpvBy00zhwCwi2FhMEAA22pFqBM9
         FeGqei9iZ5/OdnYPiq2O9TJhcKYVWrvzNTkAuHk1YTuIHg7e39GZIBdXqP/0G/3/i68s
         fgdDwZTOPm8Y4R1azmZgGkSqQN+o1JBVrYoajjKrI/OuxHOntD74povfYSCDhG+nVOk2
         xs0g==
X-Gm-Message-State: AOAM530no41iLNEuTTFQjJwy6JnBcwvwzyOQeRupo3UkCvSUC6doo9/h
        3Ji/M7V121mQ1xBjq1hi/7+eQA==
X-Google-Smtp-Source: ABdhPJzQM8n3oBv1SALPP2DogMCvLv3YaBFoOhEF9vQXfThEJaNepHkbMYB/9GSb/lPpS/siqyxbNQ==
X-Received: by 2002:a17:90a:fb85:: with SMTP id cp5mr25018189pjb.214.1628019975609;
        Tue, 03 Aug 2021 12:46:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x26sm899pfm.77.2021.08.03.12.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 12:46:13 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Kees Cook <keescook@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH 0/3] Avoid card name truncation
Date:   Tue,  3 Aug 2021 12:46:07 -0700
Message-Id: <20210803194610.326030-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=643; h=from:subject; bh=3ySFWN7x+E+djXwffG2kD4zxO+GbdUjCLq52ZOvMYts=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhCZ0BdgR/6zF0CascMWcvz0eErdrVyXoO4eBsApKl PohlUQuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYQmdAQAKCRCJcvTf3G3AJmAGEA CJUXU17ndoMBDiOfv3kT6KOmZmv+5N5j0AzwjoTAuCSYV3KjeKsjmfCb1Q9iBnwNqf9brAIdkzLK0T 9r8VqM1hzXxCWvoEA1DswYtsdtIO27GiWPtpemkk8kzxwQsGLT0Sl5BS3dmrf8QogSONbLJmvtrZWh Awq1vhrGWHOkUDYbB7x5keiqhDxEPpVejxN/BZzbnbNnPf0oghUNyZp1G9j2IlSrBHUGuysLYAPwg6 WYAvNYk0OuVBQZYzNKjr3Dy+TzcRUtiJPGN/bcIa8e6J6dWBEN8vhGY5UOKI26Db+oU0ZJpk1Y2u/S kPMNNlYgQf0VZlpPmc2INwFWPglkL22vZium3sr89lt51B4zcKWZVxtSZxcZRW/UM0xtdtMX11KSkF NghOCXgg60MEC9UEN9CHsTel1aBozu98KbTM7GZB/2qFXFqMJvAWfhGrVjnndg2NLMkIYu58CZ1kbw BJY09ymG4R4xr4VNOXxEm/JwxEhlYNGSBzIRBNydMIKUBZaDvr5grB1NKCldTn0OBdaix3t3lHmQNl mm3fwlnIqdDhvkpaX8SCqYNWQumKlOOUTT5rErAx+kxZdhB9IWMH+oF4V9eHP1Kg7UMlFi1zRHcM0M BRrZOIiYbOKzYhtN3SiYHeJbMlBRRZscl0Eau+Oaxx6ciSlUk8dBb2aJdPwg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi,

While fixing some missing compile-time overflow warnings, I found a few
media devices that had their card description silently truncated. Fix
them using Hans's suggested text.

-Kees

Kees Cook (3):
  media: radio-wl1273: Avoid card name truncation
  media: si470x: Avoid card name truncation
  media: tm6000: Avoid card name truncation

 drivers/media/radio/radio-wl1273.c            | 2 +-
 drivers/media/radio/si470x/radio-si470x-i2c.c | 2 +-
 drivers/media/radio/si470x/radio-si470x-usb.c | 2 +-
 drivers/media/usb/tm6000/tm6000-video.c       | 3 +--
 4 files changed, 4 insertions(+), 5 deletions(-)

-- 
2.30.2

