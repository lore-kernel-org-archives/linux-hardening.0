Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7228C4321E
	for <linux-hardening@archiver.kernel.org>; Sun, 27 Nov 2022 01:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiK0BE1 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 26 Nov 2022 20:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiK0BE0 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 26 Nov 2022 20:04:26 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A8513D76
        for <linux-hardening@vger.kernel.org>; Sat, 26 Nov 2022 17:04:25 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 136so6917596pga.1
        for <linux-hardening@vger.kernel.org>; Sat, 26 Nov 2022 17:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PCncOI3rFABAvzFcEvfqq7tI+grXUHqW5sWRU8iB3cg=;
        b=TDJWCz0eyG+YX7KUtwk0j0I4Ki4Ux4waWw6PtcSoCGAwOf/I0uk15adazbuYeu9uf4
         KQVtfX3hocwKmffmkQKfhkLO0Zjy418BGlG+8dttyMPD72Hfu2Cs7YcArBblUIBL/+mu
         VIg1C5kg05Cb5tS1invnVvtwqs4Mbu/klOssk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PCncOI3rFABAvzFcEvfqq7tI+grXUHqW5sWRU8iB3cg=;
        b=EgzzJBKtzOi6Hd4sfuvuiLyODTw/avP84pySR+bT1zwcsdKeH0KdoAnpleZ6Y1rCtf
         SOGCsTBITyq52XQP5+XCqrbIfSZ0dGkKYEoP9fRuyKp9jdrd7Q9jCqrJwG/dRXTn4Eq0
         YI3PdOsLDGeLQ0gN/Ua8RxPOa6UBnXiq4J1JMHFwzcZyDTYNkhEUwH3UVUnqknbzcI1N
         55XQUqhFXRqYDgqoO1ivtX/STrCZc8rOY4YBCTOM3z4vfHOmix9bVLCUSEyhgIs1mxAg
         zBBx/gwMMTeWMq1oyiCVcrsdj5aHxY4ZLj5+lgAlfqSHPFhKEAQfYaysGg2etmEqgzVR
         73fA==
X-Gm-Message-State: ANoB5pn/FJrNHOmkYjlJ6SdzsMGRFcydavYQJzJoB5grSPEEgmtRRLtJ
        PpMtWnXt4eksr2867mGdGo0sNw==
X-Google-Smtp-Source: AA0mqf5JzWQwJYpLkqYHxbXdL2VtLCTN1ZoGfq1jhwDAiv/1ktBPKsICHEzR5Hd6NjFO5x/3haDeQw==
X-Received: by 2002:a63:e44:0:b0:475:2f61:bbc3 with SMTP id 4-20020a630e44000000b004752f61bbc3mr23833473pgo.435.1669511064805;
        Sat, 26 Nov 2022 17:04:24 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 123-20020a630781000000b00470275c8d6dsm4426339pgh.10.2022.11.26.17.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Nov 2022 17:04:24 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     gustavoars@kernel.org
Cc:     Kees Cook <keescook@chromium.org>, mingo@redhat.com,
        dave.hansen@linux.intel.com, hpa@zytor.com, luto@kernel.org,
        tglx@linutronix.de, bp@alien8.de, peterz@infradead.org,
        x86@kernel.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] mm/pgtable: Fix multiple -Wstringop-overflow warnings
Date:   Sat, 26 Nov 2022 17:03:44 -0800
Message-Id: <166951102250.2406619.18299131310725462090.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <Yytb67xvrnctxnEe@work>
References: <Yytb67xvrnctxnEe@work>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, 21 Sep 2022 13:46:03 -0500, Gustavo A. R. Silva wrote:
> The actual size of the following arrays at run-time depends on
> CONFIG_X86_PAE.
> 
> 427         pmd_t *u_pmds[MAX_PREALLOCATED_USER_PMDS];
> 428         pmd_t *pmds[MAX_PREALLOCATED_PMDS];
> 
> If CONFIG_X86_PAE is not enabled, their final size will be zero. In that
> case, the compiler complains about trying to access objects of size zero
> when calling functions where these objects are passed as arguments.
> 
> [...]

Applied to for-next/hardening with tweaks to the commit log, thanks!

[1/1] mm/pgtable: Fix multiple -Wstringop-overflow warnings
      https://git.kernel.org/kees/c/9af98f78d2cd

-- 
Kees Cook

