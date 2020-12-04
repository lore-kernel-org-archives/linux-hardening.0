Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA42C433FE
	for <linux-hardening@archiver.kernel.org>; Fri,  4 Dec 2020 23:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8E8322D49
	for <linux-hardening@archiver.kernel.org>; Fri,  4 Dec 2020 23:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbgLDXrX (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 4 Dec 2020 18:47:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727553AbgLDXrX (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 4 Dec 2020 18:47:23 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F21C0613D1
        for <linux-hardening@vger.kernel.org>; Fri,  4 Dec 2020 15:46:37 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id d2so965523pfq.5
        for <linux-hardening@vger.kernel.org>; Fri, 04 Dec 2020 15:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ufpeo+Ar8Za9xIbYyf7Qe6TbN0AkwT1iWm/UoECGrZA=;
        b=TYkK6NyVNCykb9rbz+YQzRPEUzg8zjjeFPcfjP5cX+fa3sHpSjzMGfE0/LZwYAZKdi
         4cGUOX1Qj8JSIvS6qMYB+zJyQvHJBMm1MVAJMIEVnCwshsEBIJmolW5jU8MU8lAIDVVJ
         cJqwHJ0Lev3dpRLpAu4MyGckMWm4RHold/2vA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ufpeo+Ar8Za9xIbYyf7Qe6TbN0AkwT1iWm/UoECGrZA=;
        b=YJLDFoNjUg0DnRxgic1ZEEvTCauXFUR7BkQk+GxIf8hrnsPCR/N4YnO2AZUdwjuvK7
         hv1iQwPlgGUQiMvGxqkeHVKTQq8BV99sgAnXaGPVGOsFXsm4XzYfGlBsDW53jp4l9HzV
         F3A1hZ/APeeYAp9PQF0/tKT0J8QMMNpCs/NVr4NBhO44ALaUSnvMmXR31mH76qU39ylF
         20blw+Wae3KRYkM4aSi3m++3SM5f0pMDcNToAi6tnAEC88LSXw9zR9ln26/3T7jbbzN6
         py0xbxTF8KTc60EBwUt8anvbxGcYlV+9j+IKT5rIoUG/23pHXjeBvwWp3YAyjJdwKAo9
         qcIA==
X-Gm-Message-State: AOAM5331WSUTEHZixPZLAe7BQ38QxKOiug3RyDk9NenwvMoPl+kGAsIc
        WDQ/og804pIPYSQM/ItOTjOsRg==
X-Google-Smtp-Source: ABdhPJyrmx54Y8Gw9t8+NsxSXrWAxpTu7YxMFRas1YixbGc6qfYGD//LUwtxevFl959Sjyk+dGJ7sg==
X-Received: by 2002:a05:6a00:134d:b029:18b:2cde:d747 with SMTP id k13-20020a056a00134db029018b2cded747mr6141772pfu.60.1607125597090;
        Fri, 04 Dec 2020 15:46:37 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s5sm3326278pju.9.2020.12.04.15.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 15:46:36 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Emese Revfy <re.emese@gmail.com>,
        linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gcc-plugins: remove code for GCC versions older than 4.9
Date:   Fri,  4 Dec 2020 15:46:27 -0800
Message-Id: <160712557571.2401125.13652516939205338481.b4-ty@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201202134929.99883-1-masahiroy@kernel.org>
References: <20201202134929.99883-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, 2 Dec 2020 22:49:29 +0900, Masahiro Yamada wrote:
> Documentation/process/changes.rst says the minimal GCC version is 4.9.
> Hence, BUILDING_GCC_VERSION is greater than or equal to 4009.

Applied to for-next/gcc-plugins, thanks!

[1/1] gcc-plugins: remove code for GCC versions older than 4.9
      https://git.kernel.org/kees/c/af2d22254e8e

-- 
Kees Cook

