Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C8E6C77B7F
	for <linux-hardening@archiver.kernel.org>; Thu, 11 May 2023 20:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239190AbjEKUzB (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 11 May 2023 16:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238390AbjEKUzA (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 11 May 2023 16:55:00 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 11 May 2023 13:54:59 PDT
Received: from esa3.mentor.iphmx.com (esa3.mentor.iphmx.com [68.232.137.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9B24EDA
        for <linux-hardening@vger.kernel.org>; Thu, 11 May 2023 13:54:59 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="4983330"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa3.mentor.iphmx.com with ESMTP; 11 May 2023 12:53:57 -0800
IronPort-SDR: XhXhmoSQi4qaF/ZltfTa25CizJeKN5K//ROCWqKJ1Qb1+Dc4npSMwCW+oHx5jAodJ4qnYicKAM
 4m7R6yjONC8mWeiXEx1E6b/LhCtZ0ZREyIHWiKAB7Qsv6zQ+lYwG0iuthwEBdd3S8b+qPigmix
 oODOUVCbt9SW2E/Uwe0du0MxZ1SyMEaegtOy/ybMyNS7naqH7kkbzggXxbR5kD6YvqnbnmN7a6
 HIfzkUNH3kFhrAkoVFGlwd2zVg+A6Lhxq6zoytQsCv0/h6BtLG9prPnFWLtjY3Rfyb+rl9UzW7
 PMI=
Date:   Thu, 11 May 2023 20:53:52 +0000
From:   Joseph Myers <joseph@codesourcery.com>
To:     Kees Cook <keescook@chromium.org>
CC:     Alejandro Colomar <alx.manpages@gmail.com>, GCC <gcc@gcc.gnu.org>,
        Alejandro Colomar <alx@nginx.com>,
        Andrew Clayton <a.clayton@nginx.com>,
        Andrew Clayton <andrew@digital-domain.net>,
        <linux-hardening@vger.kernel.org>
Subject: Re: [wish] Flexible array members in unions
In-Reply-To: <202305111158.C78642624@keescook>
Message-ID: <74ee73d2-04e-ea8-9430-93929446e925@codesourcery.com>
References: <ac2550e0-2f5c-3680-08e6-0c224d043036@gmail.com> <44940599-7b43-99f6-5b09-4f050d645c7b@gmail.com> <202305111158.C78642624@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-12.mgc.mentorg.com (139.181.222.12) To
 svr-ies-mbx-10.mgc.mentorg.com (139.181.222.10)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, 11 May 2023, Kees Cook via Gcc wrote:

> On Thu, May 11, 2023 at 06:29:10PM +0200, Alejandro Colomar wrote:
> > On 5/11/23 18:07, Alejandro Colomar wrote:
> > [...]
> > > Would you allow flexible array members in unions?  Is there any
> > > strong reason to disallow them?
> 
> Yes please!! And alone in a struct, too.
> 
> AFAICT, there is no mechanical/architectural reason to disallow them
> (especially since they _can_ be constructed with some fancy tricks,
> and they behave as expected.) My understanding is that it's disallowed
> due to an overly strict reading of the very terse language that created
> flexible arrays in C99.

Standard C has no such thing as a zero-size object or type, which would 
lead to problems with a struct or union that only contains a flexible 
array member there.

-- 
Joseph S. Myers
joseph@codesourcery.com
