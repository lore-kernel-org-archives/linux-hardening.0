Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9976DC46CA1
	for <linux-hardening@archiver.kernel.org>; Mon, 18 Sep 2023 16:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjIRQDr (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 18 Sep 2023 12:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjIRQDq (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 18 Sep 2023 12:03:46 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8484689
        for <linux-hardening@vger.kernel.org>; Mon, 18 Sep 2023 09:03:41 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-79d27df62f1so10586239f.0
        for <linux-hardening@vger.kernel.org>; Mon, 18 Sep 2023 09:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1695052956; x=1695657756; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Vk4FgIcW1TSMW2JsWYrGwWF6KGqyDjo8gszSBQuYas=;
        b=3IV03S2yCr/AgHUn3EscGA6BeufCLUt7+e0UZwoLTlpPo6XyPS234cggbQT20/WXmJ
         qu0c8PyzpAI5jaI0G2VAs6QaCkw5cN18bUr0Y+NWeg4ERSItiEg7AAp7vj35Ddl6hkvS
         r89pCd103DTVHh2sy9Z7drtXDGyfRM1H84g+d6Sx4/jDZy9/EaiwEbzItmmjDXdVTrsy
         wdtOmt1noY0Gcqh99PqfPBXhgt8gTU7cSb9EDhAn56FCTKzZlN0kYhqxswfjG8+3HRSM
         lYMGeN+mmcQ5RRs5uhNfJljnR+f1213SN9kSWgBqJa2/vOS7+WC4fuhpYYfGMLIfBQxi
         cqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695052956; x=1695657756;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Vk4FgIcW1TSMW2JsWYrGwWF6KGqyDjo8gszSBQuYas=;
        b=POxeR5Tfi9xW/j34LQV6nyd3toCRG+3EGDCzNIh+g49kQFInzyEGV0g3u9+2JaWoi2
         QBdLz/7+2Earx/flT6lx2Qdfrj50DQkw0HSmeKzefMiexpGNnGfKHEL3g1UJfAq6F4Wh
         3XjIdJaLFxy7pHus4AteTBTHwqYok6V6N8cnLq7OPwEq951U8n6jgISw/YsCr8YemN1P
         9V696m5X9ZPKsbXdtOvjUra/P8RVyg6sgUsJd/+UfzIWChL4nBE08yPqTuxb36YnyPAE
         rHdOoj4pDNTd1Dv325g9TYjh5mQ8ThnU9UWzASbThvvWmyTQ6Syy3yRYiAaunHsWo6Qt
         1LQQ==
X-Gm-Message-State: AOJu0YxeqKkHl247Bh5DIFEAAFivNLKTz4+G3YVRX0Cxr1jiYklkfcTR
        rghItsOCDXGS/rrnROl+5JR0MMnk80tzJ20Ea2O64w==
X-Google-Smtp-Source: AGHT+IF0ETGJxFGCPdWLjhdcq5kYB6tsNKFHCvPsF+dF0bkZx+4sJ6IG49WpbNpJND4QZJhorYYf7Q==
X-Received: by 2002:a05:6602:88c:b0:792:8011:22f with SMTP id f12-20020a056602088c00b007928011022fmr8546560ioz.0.1695045568156;
        Mon, 18 Sep 2023 06:59:28 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id em8-20020a0566384da800b0042b068d921esm2836235jab.16.2023.09.18.06.59.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 06:59:27 -0700 (PDT)
Message-ID: <a6dc1618-249c-48db-a7d5-fe0415ae2afb@kernel.dk>
Date:   Mon, 18 Sep 2023 07:59:26 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] null_blk: refactor deprecated strncpy
Content-Language: en-US
To:     Justin Stitt <justinstitt@google.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>
References: <20230918-strncpy-drivers-block-null_blk-main-c-v2-1-cd9b109edfdf@google.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230918-strncpy-drivers-block-null_blk-main-c-v2-1-cd9b109edfdf@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 9/18/23 1:25 AM, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].

Commit title again...

-- 
Jens Axboe

