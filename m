Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D27C7EE22
	for <linux-hardening@archiver.kernel.org>; Wed, 10 May 2023 21:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236090AbjEJVJz (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 10 May 2023 17:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237034AbjEJVJx (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 10 May 2023 17:09:53 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18C2210C
        for <linux-hardening@vger.kernel.org>; Wed, 10 May 2023 14:09:52 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-643ac91c51fso4676996b3a.1
        for <linux-hardening@vger.kernel.org>; Wed, 10 May 2023 14:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683752992; x=1686344992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENFy+sLOlFINgLHpwtbB3Etq2m1RDg+D2xn9XgOFptQ=;
        b=XCWzOHZJGax+ETRUrlZctUyfMQgaI2zUPgBzO9Uyyf8v4xfbQQky4xBD2UXYG1E3v3
         9P3y3+IT+K5UIP2Q2pjGAACy1RZaWhqpVoJrSfFvNr2+0H3Y9jZKXdCs3t8p8f+hg6Nm
         vewWb/Qry1d1IlmOfbbr/W6pxyLqXQ61BCdLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683752992; x=1686344992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ENFy+sLOlFINgLHpwtbB3Etq2m1RDg+D2xn9XgOFptQ=;
        b=GaaON49AlmAibZtaICVq9b1lrsEVy/qWO+xirnKcu/LRjsLE+MSEpeg07A5Gnk+ecn
         DMyMWVaAvUCaUmIUr74lmeIB382qWn8pNOX/MLP1W6JrypxmwZvv9W0UTt98Qdd720zT
         J51YBaXW5u7c7bOGwb6rFm2olfIucu3UnVNMR6KJdpRIJjjzxrjWQB37wCPBSvWLvbXV
         QVbfmwBgGEZBSDIckC9C5gwO+Gr1Oxt4Aq69DvAtc/dzbXFdESlzeUdHSw9tYK7c6P9i
         Kni8ryFuHy5Wg0JBUmkOUmnGOA26hKWC6DWE3bIjb963QJkIwoNpcD7I+vK+SMC0dAZS
         n2Cg==
X-Gm-Message-State: AC+VfDybilLvqdwd9JXF/YY3fZC9YUDNqT0jgLmfWNJf2AgG6OxslsIB
        1oAHopGgDYVRfAsMTCDBouWHzw==
X-Google-Smtp-Source: ACHHUZ4gbch4ZPH7x8gayLyfQkXuri7/+DuE8u7HV88Qv0fq/GWrYt9s6yAxmDsAvTkYiX7wLhBaJw==
X-Received: by 2002:a05:6a20:7345:b0:100:bda9:4b37 with SMTP id v5-20020a056a20734500b00100bda94b37mr14040932pzc.57.1683752992391;
        Wed, 10 May 2023 14:09:52 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q16-20020a62e110000000b0062dae524006sm3917512pfh.157.2023.05.10.14.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 14:09:51 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Kees Cook <keescook@chromium.org>, kernel@pengutronix.de,
        Tony Luck <tony.luck@intel.com>, gpiccoli@igalia.com,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] pstore/ram: Convert to platform remove callback returning void
Date:   Wed, 10 May 2023 14:07:20 -0700
Message-Id: <168375283737.2438356.7396268515330470842.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230401120000.2487153-1-u.kleine-koenig@pengutronix.de>
References: <20230401120000.2487153-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, 1 Apr 2023 14:00:00 +0200, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
> 
> [...]

Applied to for-next/pstore, thanks!

[1/1] pstore/ram: Convert to platform remove callback returning void
      https://git.kernel.org/kees/c/48f2c681df43

I will send this Linus's way for -rc2. Apologies for the delay!

-- 
Kees Cook

