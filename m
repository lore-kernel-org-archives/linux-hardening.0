Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71459C433FE
	for <linux-hardening@archiver.kernel.org>; Wed, 19 Oct 2022 22:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbiJSWiE (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 19 Oct 2022 18:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbiJSWiD (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 19 Oct 2022 18:38:03 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DCB181DA2
        for <linux-hardening@vger.kernel.org>; Wed, 19 Oct 2022 15:38:00 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id h14so1594207pjv.4
        for <linux-hardening@vger.kernel.org>; Wed, 19 Oct 2022 15:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lBEtTaAMvaSVn1ITSrKOBCy/b3omP7IO7py5Uypc2JQ=;
        b=YtPguPBsqbzHiJBZmqQfjIeT52slR6ndyGuAXfl44ARkWA9NULyA+2QqydjigRpSTs
         lyVKOKTTnflLR8Sek2vfoaJoy9j4PpPPAquGUnzG2NdEkViMuIAj5c2w/ZlDIwNbcoKm
         Lna3d6H0MNw4DqWdDagnAQEKiQkMLGd5BH2Zs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lBEtTaAMvaSVn1ITSrKOBCy/b3omP7IO7py5Uypc2JQ=;
        b=C6kj+gbz2U2U6BX2pG2nBX6thspYY2LLuF+86fbmvafhl6M5HXFNzTKQH2hxLwATJA
         4EceCZKHvGmPUvfzYb2bdUf5focxQ+mAy4iwiD+PyT26VB4ZcKuGQyE3cyOzGN+aCF5v
         4RFwbS7sKVuPecDe/FPbGGwzyQB32ZkBVvNVpxZIpglmqVF+CB7a03fCSnjOY02CWwne
         4bce24lR47fM6PUDBI88fwLZXxztMzisuYLOEFWIsmSzQqjNpr4wKCIt36AES5OorJq2
         6oVGY+vnNpRSHDpkiZzUB1lEEJxSwc9siAF31tOD2aGn7l9lbFj5eNPOJONgW4HoYB2i
         MNVQ==
X-Gm-Message-State: ACrzQf39vuQ5aQlDR620/RoutwBjZrTLf6HM5ZdyHVuca5HzFOyB6Was
        O/ySwXWguuZZARfook3T6AEgtA==
X-Google-Smtp-Source: AMsMyM42q4hukWJ8s+87Aom8F/ySTX80xNdBtjpESQf9Tfre9QYa5V+kAdwE25fC62er7sXOZ90JzA==
X-Received: by 2002:a17:902:f541:b0:181:83e4:4910 with SMTP id h1-20020a170902f54100b0018183e44910mr10811623plf.109.1666219079876;
        Wed, 19 Oct 2022 15:37:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g12-20020a65594c000000b0043a1c0a0ab1sm10677165pgu.83.2022.10.19.15.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 15:37:59 -0700 (PDT)
Date:   Wed, 19 Oct 2022 15:37:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, KP Singh <kpsingh@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/9] integrity: Prepare for having "ima" and "evm"
 available in "integrity" LSM
Message-ID: <202210191219.EEEA3E20C@keescook>
References: <20221013222702.never.990-kees@kernel.org>
 <20221013223654.659758-1-keescook@chromium.org>
 <08a8b202-69b4-e154-28f5-337a898acf61@digikod.net>
 <202210141050.A8DF7D10@keescook>
 <0d2b9d34-2eda-8aa6-d596-eb1899645192@digikod.net>
 <202210191129.BFBF8035@keescook>
 <2ce5e63dc4f15b8015fd7499120ff4256ad1f619.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ce5e63dc4f15b8015fd7499120ff4256ad1f619.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Oct 19, 2022 at 03:13:34PM -0400, Mimi Zohar wrote:
> Most people were/are still using the "security=" boot command line
> option, not "lsm=".  This previously wasn't a problem with "security=",
> but became a problem with "lsm=".

How are people still using "security=" for IMA/EVM? It only interacts
with LSMs marked with LSM_FLAG_LEGACY_MAJOR.

-- 
Kees Cook
