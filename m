Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E90ECAAD4
	for <linux-hardening@archiver.kernel.org>; Wed, 31 Aug 2022 19:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbiHaT0f (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 31 Aug 2022 15:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbiHaT0e (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 31 Aug 2022 15:26:34 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04987E343E
        for <linux-hardening@vger.kernel.org>; Wed, 31 Aug 2022 12:26:31 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id h11-20020a17090a470b00b001fbc5ba5224so252733pjg.2
        for <linux-hardening@vger.kernel.org>; Wed, 31 Aug 2022 12:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=6n7Eu1ta9una9qyMHFv9XMxljrhyT7+TH3jaU8Dm+Bg=;
        b=R0t2HbSLJNz/FBnYH9ZqUSqOd9IdFL8JZFTYc43ONxL0mCwZNhyXR0B9VC5H8d8yVK
         n/Un4rbIpG+iA94HDOKuRmtooTuVWMDk1M0NBKiVtC9VecehMvjkJ50tiK/FlWAhL5Vx
         QIAMTgby39iRz19dr9XFJx1gC6RFfyY7btuvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=6n7Eu1ta9una9qyMHFv9XMxljrhyT7+TH3jaU8Dm+Bg=;
        b=vNVsHw7UiLy3wgKQ2yL0RMAMFHNLGdvGR6ZrzVjCS6sL38PCqxqCMg01mi8SH7YVZC
         95V0O2tjcCnUqcJAtgieD1x95twAwy9ROrxWl8L3H9vXScwMA2mezRQdS1GOmkhcqfwj
         pgUCP7L8X+9PD+eFvBx4qg770H3AewzqW1OuzhEgMuY0roWPBZUJjezO3ZZ59LVLWV2s
         4GQvvQSeYauBMa0O0KpS/cVQUJEZa0+A94t4/yWelyBodrAEU8J/1y5i1iM24c3OnPLj
         4k2LKsJIa+l9zTbpOUcUr1J4aEhlGtdpfrUoAkhQloPgZGIo/cvAE2nlnhOm2HsONp8F
         cNlg==
X-Gm-Message-State: ACgBeo3+eox3CZ9chF64y2mFVIQL13HNn13krO3nUYfp+fTFCIkkfd09
        ndoLoxT5sbrm+mSC9eKJSkTCCQ==
X-Google-Smtp-Source: AA6agR5Ye/RIwZJ+U32GqPBUDn3wdgnISuRQaYwABtUjAZVYVrmE0NA5w+6+eHjmw8u8JtrABdVHiw==
X-Received: by 2002:a17:902:cf0c:b0:172:a41b:63a8 with SMTP id i12-20020a170902cf0c00b00172a41b63a8mr27107308plg.161.1661973990509;
        Wed, 31 Aug 2022 12:26:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q9-20020a170902bd8900b0016f035dcd75sm11878243pls.193.2022.08.31.12.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 12:26:29 -0700 (PDT)
Date:   Wed, 31 Aug 2022 12:26:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] net/ipv4: Use __DECLARE_FLEX_ARRAY() helper
Message-ID: <202208311226.2454C8050A@keescook>
References: <Yw+yqpCd5A/Q1oo5@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yw+yqpCd5A/Q1oo5@work>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Aug 31, 2022 at 02:12:42PM -0500, Gustavo A. R. Silva wrote:
> We now have a cleaner way to keep compatibility with user-space
> (a.k.a. not breaking it) when we need to keep in place a one-element
> array (for its use in user-space) together with a flexible-array
> member (for its use in kernel-space) without making it hard to read
> at the source level. This is through the use of the new
> __DECLARE_FLEX_ARRAY() helper macro.
> 
> The size and memory layout of the structure is preserved after the
> changes. See below.
> 
> Before changes:
> 
> $ pahole -C ip_msfilter net/ipv4/igmp.o
> struct ip_msfilter {
> 	union {
> 		struct {
> 			__be32     imsf_multiaddr_aux;   /*     0     4 */
> 			__be32     imsf_interface_aux;   /*     4     4 */
> 			__u32      imsf_fmode_aux;       /*     8     4 */
> 			__u32      imsf_numsrc_aux;      /*    12     4 */
> 			__be32     imsf_slist[1];        /*    16     4 */
> 		};                                       /*     0    20 */
> 		struct {
> 			__be32     imsf_multiaddr;       /*     0     4 */
> 			__be32     imsf_interface;       /*     4     4 */
> 			__u32      imsf_fmode;           /*     8     4 */
> 			__u32      imsf_numsrc;          /*    12     4 */
> 			__be32     imsf_slist_flex[0];   /*    16     0 */
> 		};                                       /*     0    16 */
> 	};                                               /*     0    20 */
> 
> 	/* size: 20, cachelines: 1, members: 1 */
> 	/* last cacheline: 20 bytes */
> };
> 
> After changes:
> 
> $ pahole -C ip_msfilter net/ipv4/igmp.o
> struct ip_msfilter {
> 	__be32                     imsf_multiaddr;       /*     0     4 */
> 	__be32                     imsf_interface;       /*     4     4 */
> 	__u32                      imsf_fmode;           /*     8     4 */
> 	__u32                      imsf_numsrc;          /*    12     4 */
> 	union {
> 		__be32             imsf_slist[1];        /*    16     4 */
> 		struct {
> 			struct {
> 			} __empty_imsf_slist_flex;       /*    16     0 */
> 			__be32     imsf_slist_flex[0];   /*    16     0 */
> 		};                                       /*    16     0 */
> 	};                                               /*    16     4 */
> 
> 	/* size: 20, cachelines: 1, members: 5 */
> 	/* last cacheline: 20 bytes */
> };
> 
> In the past, we had to duplicate the whole original structure within
> a union, and update the names of all the members. Now, we just need to
> declare the flexible-array member to be used in kernel-space through
> the __DECLARE_FLEX_ARRAY() helper together with the one-element array,
> within a union. This makes the source code more clean and easier to read.
> 
> Link: https://github.com/KSPP/linux/issues/193
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
