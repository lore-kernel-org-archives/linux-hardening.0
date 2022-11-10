Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52AA6C433FE
	for <linux-hardening@archiver.kernel.org>; Thu, 10 Nov 2022 09:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiKJJOz (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 10 Nov 2022 04:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiKJJOv (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 10 Nov 2022 04:14:51 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929BC68697
        for <linux-hardening@vger.kernel.org>; Thu, 10 Nov 2022 01:14:50 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id j16so1958799lfe.12
        for <linux-hardening@vger.kernel.org>; Thu, 10 Nov 2022 01:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWtnQJaZ/DC2sr1Ii69yeGSZuxu9g3YJF6gE4/PvhMI=;
        b=IyqPqR2HfrTjYWOP26a2uWXKScvs+iwrE2hWCYZOtcqow8xOBNXqf+yqpdAcyAihQD
         anjFfES39Wc3rbVkiYr0dw8tXWiORSEIB6LB9Av6KxIEIIXU8aKRczr4YeFLum9y2JXS
         zR+e2d+V6AWcV+qKg+Rsd23WST+VtCuejCJKGoVajT+GlAvyZ54/WoncChoty4k7JwZx
         T7KnMY30EKzqIw7EAvu2ok1Y/jy8etdvMRJO0/26JnkksiPCkOcqCX6z3rksL41BndP+
         PG+MEcDeEQetWgTjFZrzyHdRi1CetcvMt7QblGBfLIopVkr+IKtEmyt8TAT/F0Mzbmg2
         p9Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aWtnQJaZ/DC2sr1Ii69yeGSZuxu9g3YJF6gE4/PvhMI=;
        b=RSQGrWiDfP3VuB7Aea/5kFYxg4z6o5aHFU4m5ALg5UYQ6ITAlxXtKCOd3v1hDEauZV
         c15KUPoTPX3vvLT/oGSpPEPDBeHgB4XH9716Js6Uc/bdSRrzPpjJfBSoWDNWU/Huswy7
         vZcW246rw8nBTs7kd0PDi+901lIK+hLxIb96rNDYLUBnbBXlr8TVl5u2W7muMrJd0fc6
         0nIaw/6FOk7EbHYFgBaLFK//wiSLGeL3zf5LLkpxDmLgbnFR2cpZ/PwkSkH+jQ7uNlpH
         VuUjXAC/jNe3XpzsT+15Spv7TiPbT60TVf8Bflrj7OXGNwJcLO1t3BLxnUzEVorDmmAJ
         ctKA==
X-Gm-Message-State: ACrzQf1C/N9zejs2SJpL0QfTrcTqty0B8l4i3oJa8UqjR8oCqPMdtvU+
        3XQe4g3S1Pwxs3HJrMob/2zy/tYThM0TCQ==
X-Google-Smtp-Source: AMsMyM5SWvMuCZ7I789cGHR6D4TMVXQwi09H6ESZ3ij9ZsmEcuca6j39FFLlvqiJP0mflZ0jTY7LuA==
X-Received: by 2002:a05:6512:22d4:b0:4af:1f59:b6d0 with SMTP id g20-20020a05651222d400b004af1f59b6d0mr1294867lfu.314.1668071688997;
        Thu, 10 Nov 2022 01:14:48 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id m3-20020a0565120a8300b00492dbf809e8sm2663338lfu.118.2022.11.10.01.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 01:14:48 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     "B. Niedermayr" <benedikt.niedermayr@siemens.com>,
        linux-next@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-hardening@vger.kernel.org, gustavo@embeddedor.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        rogerq@kernel.org, tony@atomide.com, linux-omap@vger.kernel.org
Subject: Re: [PATCH] memory: omap-gpmc: fix coverity issue "Control flow issues"
Date:   Thu, 10 Nov 2022 10:14:47 +0100
Message-Id: <166807168409.17460.1069653454790290049.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221109102454.174320-1-benedikt.niedermayr@siemens.com>
References: <20221109102454.174320-1-benedikt.niedermayr@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, 9 Nov 2022 11:24:54 +0100, B. Niedermayr wrote:
> From: Benedikt Niedermayr <benedikt.niedermayr@siemens.com>
> 
> Assign a big positive integer instead of an negative integer to an
> u32 variable. Also remove the check for ">= 0" which doesn't make sense
> for unsigned integers.
> 
> 
> [...]

Applied, thanks!

[1/1] memory: omap-gpmc: fix coverity issue "Control flow issues"
      https://git.kernel.org/krzk/linux-mem-ctrl/c/10913c3c59ce04562230eee4a9d1b0d4e2808842

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
