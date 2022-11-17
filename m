Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D788C433FE
	for <linux-hardening@archiver.kernel.org>; Thu, 17 Nov 2022 00:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbiKQA14 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 16 Nov 2022 19:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbiKQA1z (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 16 Nov 2022 19:27:55 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B436317F
        for <linux-hardening@vger.kernel.org>; Wed, 16 Nov 2022 16:27:53 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id r61-20020a17090a43c300b00212f4e9cccdso3887209pjg.5
        for <linux-hardening@vger.kernel.org>; Wed, 16 Nov 2022 16:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GOfJp/fj5HzusV96DGisTfNWHmd3QApItydQHTNqdkw=;
        b=UCb1tx0XfoRRD7aMbF1pwTgDhjSL6KNbmtqzQX3q2Sq9Mj+sJ2Qz8koQ3lL1Jc5DAV
         LDtVORFYpaK70B24UJztTdIrEu2rJ8Ke7wIo/knOYNfAgSnpCGjPkyj2aFORmIjQocZg
         2/eOCqSdjoTsOHlL8ldkIbqE24X5h31zq4ABU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GOfJp/fj5HzusV96DGisTfNWHmd3QApItydQHTNqdkw=;
        b=vyueNH6z7iewgkGOkTqmi4tGuYswviMX+UD7s2b4hY0Hwvxfa4GSjVN/b+Jt2kjkYr
         K/d7WQOh6aC7fsxQ67LMPn6D4g6vP28ar/xf0TOAEfrDs3Se/Bd5HH8DDqZpqWLo58v1
         luDRIe24C5UGuP4D/yDZpjfBCLucyYyfwyvh1QM/iob6IBL8o9a+vn8aG0mz+tEghokT
         k1zQKcnlDK+QEj2TWLM0u61SdT7Ah4FTf7IB9aCtJ5DMd1tUgaRswR/500NZ1fFInxZ6
         DUlfuHmov32fTcijOLREdZIRwA+hAkWTJVfD6r4jDmPwZrfmLVhetOfb/0/iXZDRq2cF
         zXjA==
X-Gm-Message-State: ANoB5pnx1/IlLztgZLDWzNzlx/y3wc+2vYuCfrCswHxnwD8ULgJfMP/Q
        oa0/QnRULHlpK17xF9kfSDMhyw==
X-Google-Smtp-Source: AA0mqf7izgIs4tamVP5xvwZJPDhJpWbrUlVRtclK4Zm0Gem7xy+bfFhhmp2zLDMVnFyCDwTaHGh3LQ==
X-Received: by 2002:a17:90a:ff84:b0:213:1e05:f992 with SMTP id hf4-20020a17090aff8400b002131e05f992mr6254360pjb.191.1668644873195;
        Wed, 16 Nov 2022 16:27:53 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r17-20020a170903411100b00186c3727294sm12733956pld.270.2022.11.16.16.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 16:27:52 -0800 (PST)
Date:   Wed, 16 Nov 2022 16:27:51 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     David Ahern <dsahern@kernel.org>, davem@davemloft.net,
        netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v2] netlink: split up copies in the ack
 construction
Message-ID: <202211161502.142D146@keescook>
References: <20221027212553.2640042-1-kuba@kernel.org>
 <20221114023927.GA685@u2004-local>
 <20221114090614.2bfeb81c@kernel.org>
 <202211161444.04F3EDEB@keescook>
 <202211161454.D5FA4ED44@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202211161454.D5FA4ED44@keescook>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Nov 16, 2022 at 02:56:25PM -0800, Kees Cook wrote:
> On Mon, Nov 14, 2022 at 09:06:14AM -0800, Jakub Kicinski wrote:
> > On Sun, 13 Nov 2022 19:39:27 -0700 David Ahern wrote:
> > > On Thu, Oct 27, 2022 at 02:25:53PM -0700, Jakub Kicinski wrote:
> > > > diff --git a/include/uapi/linux/netlink.h b/include/uapi/linux/netlink.h
> > > > index e2ae82e3f9f7..5da0da59bf01 100644
> > > > --- a/include/uapi/linux/netlink.h
> > > > +++ b/include/uapi/linux/netlink.h
> > > > @@ -48,6 +48,7 @@ struct sockaddr_nl {
> > > >   * @nlmsg_flags: Additional flags
> > > >   * @nlmsg_seq:   Sequence number
> > > >   * @nlmsg_pid:   Sending process port ID
> > > > + * @nlmsg_data:  Message payload
> > > >   */
> > > >  struct nlmsghdr {
> > > >  	__u32		nlmsg_len;
> > > > @@ -55,6 +56,7 @@ struct nlmsghdr {
> > > >  	__u16		nlmsg_flags;
> > > >  	__u32		nlmsg_seq;
> > > >  	__u32		nlmsg_pid;
> > > > +	__u8		nlmsg_data[];  
> > > 
> > > This breaks compile of iproute2 with clang. It does not like the
> > > variable length array in the middle of a struct. While I could re-do the
> > > structs in iproute2, I doubt it is alone in being affected by this
> > > change.
> 
> Eww.
> 
> > 
> > Kees, would you mind lending your expertise?

Perhaps this would be better? We could leave the _header_ struct alone,
but add the data to the nlmsgerr struct instead?

diff --git a/include/uapi/linux/netlink.h b/include/uapi/linux/netlink.h
index 5da0da59bf01..d0629cb343b2 100644
--- a/include/uapi/linux/netlink.h
+++ b/include/uapi/linux/netlink.h
@@ -48,7 +48,6 @@ struct sockaddr_nl {
  * @nlmsg_flags: Additional flags
  * @nlmsg_seq:   Sequence number
  * @nlmsg_pid:   Sending process port ID
- * @nlmsg_data:  Message payload
  */
 struct nlmsghdr {
 	__u32		nlmsg_len;
@@ -56,7 +55,6 @@ struct nlmsghdr {
 	__u16		nlmsg_flags;
 	__u32		nlmsg_seq;
 	__u32		nlmsg_pid;
-	__u8		nlmsg_data[];
 };
 
 /* Flags values */
@@ -121,6 +119,7 @@ struct nlmsghdr {
 struct nlmsgerr {
 	int		error;
 	struct nlmsghdr msg;
+	__u8		data[];
 	/*
 	 * followed by the message contents unless NETLINK_CAP_ACK was set
 	 * or the ACK indicates success (error == 0)
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index b8afec32cff6..fe8493d3ae56 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -2514,8 +2514,7 @@ void netlink_ack(struct sk_buff *in_skb, struct nlmsghdr *nlh, int err,
 		if (!nlmsg_append(skb, nlmsg_len(nlh)))
 			goto err_bad_put;
 
-		memcpy(errmsg->msg.nlmsg_data, nlh->nlmsg_data,
-		       nlmsg_len(nlh));
+		memcpy(errmsg->data, nlmsg_data(nlh), nlmsg_len(nlh));
 	}
 
 	if (tlvlen)


-- 
Kees Cook
