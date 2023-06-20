Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB31EB64D7
	for <linux-hardening@archiver.kernel.org>; Tue, 20 Jun 2023 19:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjFTTck (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 20 Jun 2023 15:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjFTTcj (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 20 Jun 2023 15:32:39 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A171710
        for <linux-hardening@vger.kernel.org>; Tue, 20 Jun 2023 12:32:38 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b51488ad67so26331955ad.3
        for <linux-hardening@vger.kernel.org>; Tue, 20 Jun 2023 12:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687289557; x=1689881557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C26TRXbQhLRFwaqH8jM0Sdsl04Y8gvs4Z9WiQwYuZkA=;
        b=gG/qXO330ggyb+itcXm50J3zpko2jxwgCS1GP5J/P2Tgh9GZerDPJeHA92elhgFtvX
         BBuFV+OuIz888TJfT0yRaBd+rtFFu6vY+ZhwFLDRkcntlcZ3bfnyknrDmIiQj5+Cpbun
         e7i/9Zmuv6+1Sd5YixUF4UDDVe1oqkeptVKcs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687289557; x=1689881557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C26TRXbQhLRFwaqH8jM0Sdsl04Y8gvs4Z9WiQwYuZkA=;
        b=Q0QN4RoTREk36TjibmgSiOO+Gk/qkEEsYx2+A71fIQcayZpFRI2hUmO5SxiA434wYl
         d4fX0fVlK44TPxyB1fzvlgAXy16N7B0tUBPhtHiHA1CWc2ww/ZCfcfHo2ixVxdU88wqG
         NzB6lJLfQD0T1U66KQiYrBPmOLq91ehE54yptBa+mLRezNgRP7sBixPxAYb3FyMc8Ir4
         MhLJScNfJUtEmvf3kxVWv9zuPY00b/TUr+QO53NWdqwOO0/ftOWA8MkqC4MczL5Bz0q8
         /tN/c2RwrQjkHim7SgHiUlPJ5SrHo+g/AQC/CKZN7DFsTNelMVn9w3pPbNoFSD3dCpZd
         tu8w==
X-Gm-Message-State: AC+VfDwEJZkXKh3Y7wh4xH63OJXKzAYIAHiSOh4dH1K0Ye0SE/jgQaY6
        UVjuVm9HcZ6TBaWEZz1VC3saK/CjPrC/UDS0xjM=
X-Google-Smtp-Source: ACHHUZ7x+h4efpg0biJJ47ft7s5D2i0Uu4CfJW4LdWEnyWQ2Kpp/TzI2R8wEx4qiLF2796wsQYWPyg==
X-Received: by 2002:a17:903:110d:b0:1b1:9802:a31b with SMTP id n13-20020a170903110d00b001b19802a31bmr12006889plh.41.1687289557508;
        Tue, 20 Jun 2023 12:32:37 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u9-20020a17090341c900b001ac741dfd29sm1933348ple.295.2023.06.20.12.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 12:32:36 -0700 (PDT)
Date:   Tue, 20 Jun 2023 12:32:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Wireless <linux-wireless@vger.kernel.org>,
        Linux Networking <netdev@vger.kernel.org>,
        M Chetan Kumar <m.chetan.kumar@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Florian Klink <flokli@flokli.de>,
        linux-hardening@vger.kernel.org
Subject: Re: Fwd: iosm: detected field-spanning write for XMM7360
Message-ID: <202306201148.716CFF3@keescook>
References: <dbfa25f5-64c8-5574-4f5d-0151ba95d232@gmail.com>
 <0826b484-8bbc-d58f-2caf-7015bd30f827@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0826b484-8bbc-d58f-2caf-7015bd30f827@leemhuis.info>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

[regressions list to Bcc]

On Tue, Jun 20, 2023 at 11:12:40AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 20.06.23 10:44, Bagas Sanjaya wrote:
> > I notice a regression report on Bugzilla [1]. Quoting from it:
> [...]
> >> [Sa Jun 17 20:10:09 2023] memcpy: detected field-spanning write (size 16) of single field "&adth->dg" at drivers/net/wwan/iosm/iosm_ipc_mux_codec.c:852 (size 8)
> [...]
> > [1]: https://bugzilla.kernel.org/show_bug.cgi?id=217569

This looks like a legitimate bug.

Here are the structures used by drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
leading up to the memcpy() triggering this warning at line 852, with
commentary from me added:

struct mux_adb {
        struct sk_buff *dest_skb;
        u8 *buf;			// <- unbounded array
	...
};

/**
 * struct mux_adth - Structure of the Aggregated Datagram Table Header.
 ...
 * @dg:	datagramm table with variable length	// variable length you say? :)
 */
struct mux_adth {
	...
        struct mux_adth_dg dg;		// <- destination of memcpy
};

struct mux_adth_dg {
        __le32 datagram_index;
        __le16 datagram_length;
        u8 service_class;
        u8 reserved;
};					// 8 byte structure

static void ipc_mux_ul_encode_adth(struct iosm_mux *ipc_mux,
                                   struct mux_adb *ul_adb, int *out_offset)
{
	...
        struct mux_adth *adth;
	...
			// Assignment of fixed-sized structure on an
			// unbounded string (i.e. minimum size
			// constraint is now defined by structure
			// layout, which is a good thing.)
                        adth = (struct mux_adth *)&ul_adb->buf[offset];
			...
			// This appears to be preparing for having
			// _multiple_ "dg" structs at the end of
			// struct mux_adth_dg, not just 1. (And, if so,
			// should be using the struct_size(), or really,
			// given the later subtraction, the flex_size(),
			// helper.)
                        adth_dg_size = offsetof(struct mux_adth, dg) +
                                        ul_adb->dg_count[i] * sizeof(*dg);
			...
                        adth_dg_size -= offsetof(struct mux_adth, dg);
                        memcpy(&adth->dg, ul_adb->dg[i], adth_dg_size);


&adth->dg is 8 bytes, so the warning message is correct. However, it
seems like "ul_adb->dg_count[i]" contains a _count_ of "dg" structures
to copy, and, in the reported case, is "2".

The fix appears to be adjusting struct mux_adth with:

-       struct mux_adth_dg dg;
+       struct mux_adth_dg dg[];

But, since this is an implicit "1-element array to flexible array"
conversion[1], we need to double-check "sizeof" uses.

I only see 3 cases of sizeof(struct mux_adth). This one removes the
"extra" "dg" element for bounds checking:

                if (le16_to_cpu(adth->table_length) < (sizeof(struct mux_adth) -
                                sizeof(struct mux_adth_dg)))

This one adds it back in after subtracting 1 too many:

                nr_of_dg = (le16_to_cpu(adth->table_length) -
                                        sizeof(struct mux_adth) +
                                        sizeof(struct mux_adth_dg)) /
                                        sizeof(struct mux_adth_dg);

As does this one:

                        nr_of_dg = (le16_to_cpu(adth->table_length) -
                                        sizeof(struct mux_adth) +
                                        sizeof(struct mux_adth_dg)) /
                                        sizeof(struct mux_adth_dg);

So they can be simplified to avoid the extra math.

I'll send a patch...

-Kees

[1] https://github.com/KSPP/linux/issues/79

-- 
Kees Cook
