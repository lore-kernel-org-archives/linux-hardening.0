Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCA2C352A1
	for <linux-hardening@archiver.kernel.org>; Tue,  6 Dec 2022 16:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235269AbiLFQEK (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 6 Dec 2022 11:04:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234893AbiLFQCQ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 6 Dec 2022 11:02:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4751A2FA6D;
        Tue,  6 Dec 2022 08:02:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 70575B81AB0;
        Tue,  6 Dec 2022 16:02:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E9F9C433D6;
        Tue,  6 Dec 2022 16:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670342529;
        bh=NBWOhwnl7KcxTrSeISs9JWX6mP+6IYVt0QLZovZda3Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fGsNVIu1YK0x4ku78uf4vQex8Gf+lrpP3Gx6Mwx/NrVps6GS4FnbQ+VS2LmCZK2hz
         kRmnWXdCUU7JxgUkS7BmxGYbrOAsTJyJcg6mVaC8mVsHDJdibq3kGPg1ciy/gmOr0l
         P+ntQ9eX9nLfZBuelOO84u6KEEMURNnpymCsoo2Y=
Date:   Tue, 6 Dec 2022 17:02:06 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     jeffxu@chromium.org
Cc:     skhan@linuxfoundation.org, keescook@chromium.org,
        akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jeffxu@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 5/6] selftests/memfd: add tests for MFD_NOEXEC_SEAL
 MFD_EXEC
Message-ID: <Y49nfotbfHdBN+kq@kroah.com>
References: <20221206152358.1966099-1-jeffxu@google.com>
 <20221206152358.1966099-6-jeffxu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206152358.1966099-6-jeffxu@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Dec 06, 2022 at 03:23:57PM +0000, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>
> 
> Tests to verify MFD_NOEXEC, MFD_EXEC and vm.memfd_noexec sysctl.
> 
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> Co-developed-by: Daniel Verkamp <dverkamp@chromium.org>
> Signed-off-by: Daniel Verkamp <dverkamp@chromium.org>
> 
> Change-Id: Idccec1141255ca948c849f4efc8ba5e97f78b6eb

Always use checkpatch.pl on your patches so you don't get grumpy
maintainers telling you to run checkpatch.pl on your patches...

thanks,

greg k-h
