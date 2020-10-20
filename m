Return-Path: <SRS0=sPYh=D3=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31BFC43457
	for <linux-hardening@archiver.kernel.org>; Tue, 20 Oct 2020 13:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 545E9224B8
	for <linux-hardening@archiver.kernel.org>; Tue, 20 Oct 2020 13:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=privacyrequired.com header.i=@privacyrequired.com header.b="V+PbcZro"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407251AbgJTNGc (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 20 Oct 2020 09:06:32 -0400
Received: from devianza.investici.org ([198.167.222.108]:59171 "EHLO
        devianza.investici.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407046AbgJTNGb (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 20 Oct 2020 09:06:31 -0400
Received: from mx2.investici.org (unknown [127.0.0.1])
        by devianza.investici.org (Postfix) with ESMTP id 4CFv5f13rnz6vJs;
        Tue, 20 Oct 2020 13:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=privacyrequired.com;
        s=stigmate; t=1603199190;
        bh=z5nqz87b2roWuN6G7s1nsR3igN+YV1VFlqL0yfAp8Y8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V+PbcZroNqgsYgqOLkiW7Vn2d1eoYFlm0KbQdjAOsxOK/M8H0gT/eaMZp31h561wC
         9piHZG4b4HJiC2eNPezAluAH0JrKorbwzhuNtMvx9t5wXXCsKydSuVIZordz9wMpuK
         Cxg2C1CuFduJS6/FhD0tCvsJCl+5Qm4yVNC9WJmg=
Received: from [198.167.222.108] (mx2.investici.org [198.167.222.108]) (Authenticated sender: laniel_francis@privacyrequired.com) by localhost (Postfix) with ESMTPSA id 4CFv5d6hb1z6vJY;
        Tue, 20 Oct 2020 13:06:29 +0000 (UTC)
From:   Francis Laniel <laniel_francis@privacyrequired.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org, kuba@kernel.org,
        davem@davemloft.net
Subject: Re: [RFC][PATCH v2 0/3] Fix inefficiences and rename nla_strlcpy
Date:   Tue, 20 Oct 2020 15:06:29 +0200
Message-ID: <1959339.UkWeTq9UOQ@machine>
In-Reply-To: <202010191602.AA2A948@keescook>
References: <20201016125216.10922-1-laniel_francis@privacyrequired.com> <20201019152331.20583-1-laniel_francis@privacyrequired.com> <202010191602.AA2A948@keescook>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Le mardi 20 octobre 2020, 01:03:18 CEST Kees Cook a =E9crit :
> [process nit: please don't use "--in-reply-to=3D" for git send-email, as
> it ends up collecting all the versioned threads together, which makes
> them harder to review. Each version should be a separate thread.]

Thank you for the advice!
Will be done for next patch set!


