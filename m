Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9649ECAAD2
	for <linux-hardening@archiver.kernel.org>; Mon, 29 Aug 2022 19:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiH2TJA (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 29 Aug 2022 15:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiH2TI7 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 29 Aug 2022 15:08:59 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD397AC09
        for <linux-hardening@vger.kernel.org>; Mon, 29 Aug 2022 12:08:58 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id h13-20020a17090a648d00b001fdb9003787so4224565pjj.4
        for <linux-hardening@vger.kernel.org>; Mon, 29 Aug 2022 12:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=U2XaLm1XADG8fbYMIz6cHx6vAFjgu+IqCi8Hnsr82jw=;
        b=MxhKWeK2qM7uubh7v9lhINSFW6/hrilRRCqd0nnhq463y7nrh7H9tTw1z5PH1Eyk3W
         By6U9Kq2Oihnew6AaQhQssYEpW/K8UyBYrCpCXRgAD+bWPp22jDg7h0XrhW2gRHbOyVN
         eNf7fzVq34MrrwBEo4eV2jsQwog8har1zwiVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=U2XaLm1XADG8fbYMIz6cHx6vAFjgu+IqCi8Hnsr82jw=;
        b=pmJE2i5S5A3+B7diGI/PRiBnY05ssOQ4FXkVsogfgQcePlaI1Mbda0Q77jAebHLE1S
         RuSqTFzPC86F/71k2zCfAN7qxJXHhRh3+fz0Agm6aQFf7G9N/nUp47SRUb9wICkf5pc5
         0ladbhUgx1fiuHMVpQHwm06aUX7BNBY5a6bkatfoHZcEn3xtgsxoyCy+nYI9bOr0FJNm
         QoNrSyhSv1Rvy23n+a7d9naNIba/6XJ07ZNGglL17RSQ4aj4ARuITJSZUcEqlxiaOiSK
         KB624hTmThmcXH7ozSnKGEGyUiiwYydlW3xiDWu6wZ3FDouAzyVCpnmSqh/bsq4i6osW
         hhvw==
X-Gm-Message-State: ACgBeo3dlKUaAMaapWdz67Z/KGilmJH6e2jch6uc7wlv9RHo8BedSoiD
        ekXUN9fJWlPnOV1TLnHn0drX9NUXpxCooQ==
X-Google-Smtp-Source: AA6agR70yqMgxEbw0FWzYnoIwdmoliZC6YBQLDH8iofYC/WVDYBobY4koMK8nzaOswl0n7/inBz41Q==
X-Received: by 2002:a17:902:cf42:b0:172:ed15:ee with SMTP id e2-20020a170902cf4200b00172ed1500eemr17348661plg.149.1661800138103;
        Mon, 29 Aug 2022 12:08:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 8-20020a17090a018800b001fb277223bdsm7003509pjc.2.2022.08.29.12.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 12:08:57 -0700 (PDT)
Date:   Mon, 29 Aug 2022 12:08:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH v2] x86/mm: Refuse W^X violations
Message-ID: <202208291208.E19DE00ED@keescook>
References: <YwySW3ROc21hN7g9@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwySW3ROc21hN7g9@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Aug 29, 2022 at 12:18:03PM +0200, Peter Zijlstra wrote:
> 
> x86 has STRICT_*_RWX, but not even a warning when someone violates it.
> 
> Add this warning and fully refuse the transition.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
