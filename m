Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209B1C7EE22
	for <linux-hardening@archiver.kernel.org>; Thu, 11 May 2023 21:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239262AbjEKVn6 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 11 May 2023 17:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239461AbjEKVn4 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 11 May 2023 17:43:56 -0400
Received: from esa2.mentor.iphmx.com (esa2.mentor.iphmx.com [68.232.141.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7148D2127
        for <linux-hardening@vger.kernel.org>; Thu, 11 May 2023 14:43:55 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="5592447"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa2.mentor.iphmx.com with ESMTP; 11 May 2023 13:43:54 -0800
IronPort-SDR: zOdNArBLMfW2DnkTfP2ikxcqWj0SqC7CthgmwmAjhNwGED2Gz8Qty0m8PUF6FN6LE7V9A/EvPE
 +xmG0OBpaHpNdSmHzVBcvmtKG6YXrgyQN4JwXePADr0Ocw0U3zNGTqdKEypXytRNDZZEvDIErO
 4KlZLKXmXDgxIdeKCHIFR5E4Kwhevb3t+/8hbN0TPPvqkRen6AxzK2+los9Ubc1zgykEHH7vou
 +YbqWl8iHve0kWXNqFsVx32KAgG1STtl7m/Q/pd3DudUAFHfpngfrM6et3y3WOZnEjwfcgJQt9
 ehU=
Date:   Thu, 11 May 2023 21:43:49 +0000
From:   Joseph Myers <joseph@codesourcery.com>
To:     Kees Cook <keescook@chromium.org>
CC:     Alejandro Colomar <alx.manpages@gmail.com>, GCC <gcc@gcc.gnu.org>,
        Alejandro Colomar <alx@nginx.com>,
        Andrew Clayton <a.clayton@nginx.com>,
        Andrew Clayton <andrew@digital-domain.net>,
        <linux-hardening@vger.kernel.org>
Subject: Re: [wish] Flexible array members in unions
In-Reply-To: <202305111410.CFE0875F@keescook>
Message-ID: <bb3aac3c-f377-5598-cbf6-47d0be448f3@codesourcery.com>
References: <ac2550e0-2f5c-3680-08e6-0c224d043036@gmail.com> <44940599-7b43-99f6-5b09-4f050d645c7b@gmail.com> <202305111158.C78642624@keescook> <74ee73d2-04e-ea8-9430-93929446e925@codesourcery.com> <202305111410.CFE0875F@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-15.mgc.mentorg.com (139.181.222.15) To
 svr-ies-mbx-10.mgc.mentorg.com (139.181.222.10)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, 11 May 2023, Kees Cook via Gcc wrote:

> Why are zero-sized objects missing in Standard C? Or, perhaps, the better
> question is: what's needed to support the idea of a zero-sized object?

Zero-sized objects break the principle that different objects have 
different addresses, and the principle of being able to subtract pointers 
to different elements of an array.  There would also be serious C++ 
compatibility concerns, since C++ allows a struct with no members but it 
has nonzero size, unlike the GNU C extension where a struct with no 
members has size zero.

-- 
Joseph S. Myers
joseph@codesourcery.com
