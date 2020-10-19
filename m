Return-Path: <SRS0=m/Ru=D2=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7E6C433E7
	for <linux-hardening@archiver.kernel.org>; Mon, 19 Oct 2020 16:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8EDB22314
	for <linux-hardening@archiver.kernel.org>; Mon, 19 Oct 2020 16:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603125918;
	bh=KYm4hDrViPmiL5Ay9FB74C6Nf3anNOl6hF1iI7iwN2M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=qffxiKwqZ55p8VYYKSMnG5Y9isS0WdCaehiR87g3zxSvtfgF1mexOcQNyzXrUBP3v
	 YaJugM+DN+NgSzsV9kJEH9qV4OxfJIbTRRxAX682yfdYpvuYUUKp44MLg8zeS4ZITI
	 U/ESMNeK2ccrX1BW3+gMDJVteEQ8C9VXQR0n2OHs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730616AbgJSQpS (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 19 Oct 2020 12:45:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:57482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730538AbgJSQpS (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 19 Oct 2020 12:45:18 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7548F222EA;
        Mon, 19 Oct 2020 16:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603125917;
        bh=KYm4hDrViPmiL5Ay9FB74C6Nf3anNOl6hF1iI7iwN2M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=s/yyZlmUecFfeOoQEa0ESyl/+n54RCLfMmrv6xqKPAzYm3QcKgKkV7cP6lxRcIS5g
         r7Rjv29kT7u86Qe032tN+q5S6DJzStxTrGFQ1JDFQkU0s69Ec911F3owFj2nIpXEmV
         zn/KDZsxNEBVBWO7OL/NEVOBFUfH2OpMIEkl39LU=
Date:   Mon, 19 Oct 2020 09:45:15 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     laniel_francis@privacyrequired.com
Cc:     linux-hardening@vger.kernel.org, davem@davemloft.net
Subject: Re: [RFC][PATCH v2 0/3] Fix inefficiences and rename nla_strlcpy
Message-ID: <20201019094515.46db8af1@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20201019152331.20583-1-laniel_francis@privacyrequired.com>
References: <20201016125216.10922-1-laniel_francis@privacyrequired.com>
        <20201019152331.20583-1-laniel_francis@privacyrequired.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, 19 Oct 2020 17:23:28 +0200 laniel_francis@privacyrequired.com
wrote:
> To sum up, the first patch fixes an inefficiency where some bytes in dst were
> written twice, one with 0 the other with src content.
> The second one modifies nla_strlcpy to return the same value as strscpy,
> i.e. number of bytes written or -E2BIG if src was truncated.
> The third rename nla_strlcpy to nla_strcpy.
> 
> Unfortunately, I did not find how to create struct nlattr objects so I tested
> my modifications on simple char*.
> This is why I tag this patch set as RFC.
> 
> If you see any way to improve the code or have any remark, feel free to comment.

You follow semantics of strscpy, yet rename to strcpy. Wouldn't it be
more intuitive for developers to rename to nla_strscpy?

Please make sure that you CC netdev on the next iteration.
