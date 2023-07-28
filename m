Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9E4C001DF
	for <linux-hardening@archiver.kernel.org>; Fri, 28 Jul 2023 22:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234226AbjG1Wnd (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 28 Jul 2023 18:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233968AbjG1Wnc (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 28 Jul 2023 18:43:32 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F9F449E
        for <linux-hardening@vger.kernel.org>; Fri, 28 Jul 2023 15:43:28 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-686b879f605so1847956b3a.1
        for <linux-hardening@vger.kernel.org>; Fri, 28 Jul 2023 15:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690584208; x=1691189008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GqnEWXGBr+qgq+fw45Hld4bEOObqJbZc782zVcwCLuo=;
        b=d7wBzlZ64gFtXkNExZkAf2L2TcCyfy5/7eWx6u6tzjV0OTM9I4iTra1tb8g18fz1tm
         zjnf/3/RfFUj7Y1+OWcrLozJbIZ//yanLc+UeESbFh7sDGEufAtXK5yIIyWWJctPGV6f
         JcvWOOS6ij4NmpSmEFiFReD739b975jhkp6GQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690584208; x=1691189008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GqnEWXGBr+qgq+fw45Hld4bEOObqJbZc782zVcwCLuo=;
        b=aASRGmwQTN23MSwsLRITA321BeLDZEj+vyT/a116NwRbfzVM1MPP6h7y1wLhBLRxPh
         sfBU/aJ7wI59SO5jOh2rJGqK//oumj6pl9cc0qCFMw2zB97uWFtPDGK2f6/aO/6jM+D9
         aYBXCTpgO7OmGwQVdcgCR/ejaqxcMBHJHGzadfI8Xw+4HfBe4WGnd1TJsbMtI3Bs4xcB
         QMtjQPJQTSicyAZbgv2f6+tt+HXFjdr9RkZk+yyhaJ60CEpX+4hC4353SuD5bEwBpg5s
         TABMCJud2+WuX9cnxVH0Wf1vaHQZLfmiVT5qYUoIDjZvkGd+QqSvYDCn9mujEGCK/Pr4
         /ReA==
X-Gm-Message-State: ABy/qLZNZa3P5fUjVNc0TUioaobGsqZridRthIxKYCQV/w1424NpMmdV
        AvlZ+5DNs+fY2XFLDwW03BsxbQ==
X-Google-Smtp-Source: APBJJlEFOXYQokilR8cdjkWektv3laYms1B2ykj0+cKlup9KWlpd1V1VaF3ZUmqBbDxlUB7w2HGN7A==
X-Received: by 2002:a05:6a20:3251:b0:133:bbe0:30bf with SMTP id hm17-20020a056a20325100b00133bbe030bfmr2705280pzc.13.1690584207864;
        Fri, 28 Jul 2023 15:43:27 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w24-20020a170902d71800b001b8052d58a0sm4053824ply.305.2023.07.28.15.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 15:43:27 -0700 (PDT)
Date:   Fri, 28 Jul 2023 15:43:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        netdev@vger.kernel.org, linux-hardening@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] virtchnl: fix fake 1-elem arrays in structs
 allocated as `nents + 1` - 1
Message-ID: <202307281537.AC1ED9CA@keescook>
References: <20230728155207.10042-1-aleksander.lobakin@intel.com>
 <20230728155207.10042-2-aleksander.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728155207.10042-2-aleksander.lobakin@intel.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Jul 28, 2023 at 05:52:05PM +0200, Alexander Lobakin wrote:
> The two most problematic virtchnl structures are virtchnl_rss_key and
> virtchnl_rss_lut. Their "flex" arrays have the type of u8, thus, when
> allocating / checking, the actual size is calculated as `sizeof +
> nents - 1 byte`. But their sizeof() is not 1 byte larger than the size
> of such structure with proper flex array, it's two bytes larger due to
> the padding. That said, their size is always 1 byte larger unless
> there are no tail elements -- then it's +2 bytes.
> Add virtchnl_struct_size() macro which will handle this case (and later
> other cases as well). Make its calling conv the same as we call
> struct_size() to allow it to be drop-in, even though it's unlikely to
> become possible to switch to generic API. The macro will calculate a
> proper size of a structure with a flex array at the end, so that it
> becomes transparent for the compilers, but add the difference from the
> old values, so that the real size of sorta-ABI-messages doesn't change.
> Use it on the allocation side in IAVF and the receiving side (defined
> as static inline in virtchnl.h) for the mentioned two structures.

This all looks workable, but it's a unique solution in the kernel. That
is fine, of course, but would it be easier to maintain/test if it went
with the union style solutions?

struct foo {
	...
	union {
		type legacy_padding;
		DECLARE_FLEX_ARRAY(type, member);
	};
};

Then the size doesn't change and "member" can still be used. (i.e. no
collateral changes needed.)

-Kees

-- 
Kees Cook
