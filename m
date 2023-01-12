Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A96C54EBE
	for <linux-hardening@archiver.kernel.org>; Thu, 12 Jan 2023 22:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240314AbjALWuC (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 12 Jan 2023 17:50:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239946AbjALWtt (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 12 Jan 2023 17:49:49 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0EA5E644
        for <linux-hardening@vger.kernel.org>; Thu, 12 Jan 2023 14:49:48 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id q23-20020a17090a065700b002290913a521so2903693pje.5
        for <linux-hardening@vger.kernel.org>; Thu, 12 Jan 2023 14:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/3aINzABZ+B32eDJiQaUrol+gjhErI5EOh92lsUgR+o=;
        b=VEG3BOvGNDWwIjkpPBU5exuoMBPFrh+0WzjNCrvcnDKHBaAFzRe+M42kMeMYj/seCl
         mrS/x+qHl+2y4PqXmkB0bkShZY3isMlGPg4lue8PFeTmVdg/Y7wEcSDcLOqIDIUc6pyB
         zMQteSUDAqHwr8buQyP9OpxkMOjM2m7+JuuEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/3aINzABZ+B32eDJiQaUrol+gjhErI5EOh92lsUgR+o=;
        b=EPBzUZulFJ+k9EraWQNUiifDl0+ImpfhehGUnhPvn2r1k7MlJo2Q4uTETQ/eQZapdP
         YhpbsCKQZFjIIFzyGVFiOzXP/CqcHpvku9rvL8ggeAqYGV+cr0I9Jx53Tc0eoZHyjK8h
         AbDB/QbqYcBr6Wle8E/4iGmOm7T9iSZ2PAJ/GKzl5bOZg5rMPKMzrmOg52bkYM4aZiqt
         Xn78MdEsB+5vAuF7JaObY5U6xuihrPiF7ARm38g5qkFSFM7G+eqbdvLrqF7YZvX2eHuO
         siITbcBUCRCxp0JizqgUynxQzyJKeU/r7mqTTHpH2eL4DF3cj9vrud/70Rod6gzi8Qb3
         33Ig==
X-Gm-Message-State: AFqh2kr0ORBV3izQsdMPRI/TmmNU50SpnfFLKxNMT85mrPmW8+QyalNV
        IUbzDHmAOoijaMHjD0Yb/FmOfg==
X-Google-Smtp-Source: AMrXdXuPKLEaW2H2pNiU4cq1J1wZjDOdMtRcbbPfK1/O/q747uLTjN7/ZyJOOUpn4RAXqtUj1CmkSw==
X-Received: by 2002:a17:902:ef45:b0:18b:271e:5800 with SMTP id e5-20020a170902ef4500b0018b271e5800mr92780134plx.19.1673563787696;
        Thu, 12 Jan 2023 14:49:47 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q1-20020a170902a3c100b001899c2a0ae0sm12719205plb.40.2023.01.12.14.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 14:49:47 -0800 (PST)
Date:   Thu, 12 Jan 2023 14:49:46 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] nvmem: u-boot-env: replace zero-length array with
 flexible-array member
Message-ID: <202301121449.820DF6D84F@keescook>
References: <Y7zB+s2AC6O+CRR+@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7zB+s2AC6O+CRR+@work>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Jan 09, 2023 at 07:40:10PM -0600, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated[1] and we are moving towards
> adopting C99 flexible-array members instead. So, replace zero-length
> array declaration in struct u_boot_env_image_broadcom with flex-array
> member.
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
