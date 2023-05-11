Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBD5C77B7C
	for <linux-hardening@archiver.kernel.org>; Thu, 11 May 2023 22:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238921AbjEKWwc (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 11 May 2023 18:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238053AbjEKWwc (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 11 May 2023 18:52:32 -0400
Received: from esa2.mentor.iphmx.com (esa2.mentor.iphmx.com [68.232.141.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED11E42
        for <linux-hardening@vger.kernel.org>; Thu, 11 May 2023 15:52:31 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="5596161"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa2.mentor.iphmx.com with ESMTP; 11 May 2023 14:52:31 -0800
IronPort-SDR: ocSW3JRScdrJzbDdvklpCVOJ/yoa4V+KWMngDsMe4FXNS2rV6K4a7QpkhVAVo2KmEf2KoTCk/5
 yBHUAf0rhlOtDUuhsXskKlnz84jMX+/W3BzSV4QK6+/JLIlPqIAHHC6Nkvap7ftyOS2GZ3WQ2N
 /cAaPUvuLdEG+RHvS7Gs1cAXJzU+kbBSwFQYbI/OvGOW0xDv+lr+PxLaMKVEKYtQLaCdXN4obf
 xUYaVkXMF69Hf4sqrIQh+28RdJlka5NTRBJfUaUjUjq2UXsXHGbhX/yzCnJiQCUVIGdhvzcjqO
 EuY=
Date:   Thu, 11 May 2023 22:52:25 +0000
From:   Joseph Myers <joseph@codesourcery.com>
To:     Kees Cook <keescook@chromium.org>
CC:     Alejandro Colomar <alx.manpages@gmail.com>, GCC <gcc@gcc.gnu.org>,
        Alejandro Colomar <alx@nginx.com>,
        Andrew Clayton <a.clayton@nginx.com>,
        Andrew Clayton <andrew@digital-domain.net>,
        <linux-hardening@vger.kernel.org>
Subject: Re: [wish] Flexible array members in unions
In-Reply-To: <202305111514.576EB7F@keescook>
Message-ID: <a9f2739c-7582-853e-ea94-e13f5ea4698@codesourcery.com>
References: <ac2550e0-2f5c-3680-08e6-0c224d043036@gmail.com> <44940599-7b43-99f6-5b09-4f050d645c7b@gmail.com> <202305111158.C78642624@keescook> <74ee73d2-04e-ea8-9430-93929446e925@codesourcery.com> <202305111410.CFE0875F@keescook>
 <bb3aac3c-f377-5598-cbf6-47d0be448f3@codesourcery.com> <202305111514.576EB7F@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-14.mgc.mentorg.com (139.181.222.14) To
 svr-ies-mbx-10.mgc.mentorg.com (139.181.222.10)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, 11 May 2023, Kees Cook via Gcc wrote:

> Okay, understood. If this is a C-only thing, we can ignore the C++
> impact.

We're a lot more careful lately in WG14 about checking for C++ 
compatibility issues and expecting approval from the liaison group for 
anything with possible compatibility concerns for syntax in the common 
subset of C and C++.  So, no, we can't ignore the C++ impact for adding 
empty types; it would need careful consideration in the liaison group.

> What depends on the "different objects have different addresses"
> principle? And why do unions not break this -- they could point to the
> same locations within the object? And don't flexible arrays already need
> special handling in this regard?

"including a pointer to an object and a subobject at its beginning" and 
"one is a pointer to one past the end of one array object and the other is 
a pointer to the start of a different array object that happens to 
immediately follow the first array object in the address space" are both 
cases included in the semantics for comparison operators.  If you allow 
zero-size objects you get more special cases there (and quite possibly 
affect optimizations based on points-to analysis that can determine 
pointers are based on different objects, if an object is not known at 
compile time to have nonzero size).

-- 
Joseph S. Myers
joseph@codesourcery.com
