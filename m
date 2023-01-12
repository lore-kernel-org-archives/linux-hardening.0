Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84062C54EBE
	for <linux-hardening@archiver.kernel.org>; Thu, 12 Jan 2023 22:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240618AbjALWuL (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 12 Jan 2023 17:50:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240568AbjALWuE (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 12 Jan 2023 17:50:04 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF2F5E64B
        for <linux-hardening@vger.kernel.org>; Thu, 12 Jan 2023 14:50:03 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id c6so21686903pls.4
        for <linux-hardening@vger.kernel.org>; Thu, 12 Jan 2023 14:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YeyAehJ1+RpbbyKeSeI182mikP/hWhpWtc+icM9rV9Q=;
        b=LRhcyfx/gJrJ613xcnpLoHxo/rRB8wFX8vEVKquTu7z1/Lg1HGxSwA8bxtV7XODtji
         stKDzRYqwx6OPVhHfj5j369tTog4pVrAkwnMy0+BF17inAH4JWw63ZWuDb97/Kf6zk9i
         U9KLt/YedDyjUP8Ut+itFQaAcMhcTYUR+9Uks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YeyAehJ1+RpbbyKeSeI182mikP/hWhpWtc+icM9rV9Q=;
        b=xfoW8nK5a52mfbweDPfzyeSEHMqVAVz8ODgNV6QB5lndu+eIQdcMPQN0s6slevAclJ
         fO4EJXsClwuAqlzinNilOCPs2JI9iYpNFg4aFG5w2o3bHl54TJGPe2T+nylE3wmSDkrT
         LZ8n0ayHOfekYntuthOmDxe8Vz60x/X1uGnMLw4+Wiy4bJLdBnoeLEsK879DcCNtHucl
         kaDmTd3m6OErGxlJDH+wkoWFLnmQ8ARe5k31S1CdeF2L7IgiWjwIvOAxb9nby92S4oCn
         GFhkg94W3G2EGZT1o9/IVwBDZIbJbsq03lVjJT4qdIdNWIij3WZiB8xtiIF1iSWCMIFF
         5jlg==
X-Gm-Message-State: AFqh2kqHxvm1HCYUcnU58hTQ+Gmh7BDWK1FejsLZe7hXGZz0nr+GMvOv
        KscF29yXKScJQtFt5ueP1knGxQ==
X-Google-Smtp-Source: AMrXdXscOB5DMopj230A+iRjb+JA0VFUMffsTa29UCCUsv1241CuexvhrVtH+xb/y6XgpLjfsB7JiA==
X-Received: by 2002:a17:902:ab11:b0:191:33e2:452d with SMTP id ik17-20020a170902ab1100b0019133e2452dmr71359028plb.24.1673563803297;
        Thu, 12 Jan 2023 14:50:03 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q1-20020a170902dac100b0019141c79b1dsm12673819plx.254.2023.01.12.14.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 14:50:02 -0800 (PST)
Date:   Thu, 12 Jan 2023 14:50:02 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] x86/fpu: Replace zero-length array with
 flexible-array member
Message-ID: <202301121450.E16A538D9@keescook>
References: <Y7zCFpa2XNs/o9YQ@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7zCFpa2XNs/o9YQ@work>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Jan 09, 2023 at 07:40:38PM -0600, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated[1] and we are moving towards
> adopting C99 flexible-array members instead. So, replace zero-length
> array declaration in struct xregs_state with flex-array member.
> 
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> routines on memcpy() and help us make progress towards globally
> enabling -fstrict-flex-arrays=3 [2].
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays [1]
> Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [2]
> Link: https://github.com/KSPP/linux/issues/78
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
