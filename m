Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AE5C25B08
	for <linux-hardening@archiver.kernel.org>; Sat, 20 Aug 2022 06:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243357AbiHTGa3 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 20 Aug 2022 02:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiHTGa2 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 20 Aug 2022 02:30:28 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0167DB07D5
        for <linux-hardening@vger.kernel.org>; Fri, 19 Aug 2022 23:30:26 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4M8pdn2MtGz4x1d;
        Sat, 20 Aug 2022 16:30:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1660977022;
        bh=mkvuAfik4MDqQ5XVrCQn6kJD1RXu6Mfh8t/ravQHwKk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=BTeQ2VjRrhzhruIh4et4Ycp2FT6LZzKzhgcUKku88EadjeRClcB2JQleCyjd+mP9P
         lRsyS/bkrRSOXI/OqvorTNTASRgTkvh1M04dQ9VV64o3moDPxsGtdVeWAT1QiglhTd
         KD8VcO6T85kpJNPieIDO+2FlnjdnauUFJMzEm9IT1fvzJOADjbZTN1WmV4QNzcK7he
         VviN4g9KXHY5+o8kWbrK6fM1eayyoeP62SgQ4j3ikZYprOZHSYPgoYLF/6WQU0BxxA
         uWEUqmf7AxXMGb39w9ogsWfan0ccEmHfsoJZpdSJMueRPoB8F7MSRpQpgjI5oTnaMj
         //0TpiGfnCLUQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Nicholas Miehlbradt <nicholas@linux.ibm.com>,
        Jordan Niethe <jniethe5@gmail.com>,
        Russell Currey <ruscur@russell.cc>,
        linuxppc-dev@lists.ozlabs.org
Cc:     ajd@linux.ibm.com, anshuman.khandual@arm.com,
        aneesh.kumar@linux.ibm.com, npiggin@gmail.com,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4 2/2] selftests/powerpc: Add a test for execute-only
 memory
In-Reply-To: <daffd6e0-7dd7-8699-6136-fa63a15a7b47@linux.ibm.com>
References: <20220817050640.406017-1-ruscur@russell.cc>
 <20220817050640.406017-2-ruscur@russell.cc>
 <faa82449f058e4d57372dc4e7b5ca2dc091cb454.camel@gmail.com>
 <daffd6e0-7dd7-8699-6136-fa63a15a7b47@linux.ibm.com>
Date:   Sat, 20 Aug 2022 16:30:18 +1000
Message-ID: <87tu67l951.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Nicholas Miehlbradt <nicholas@linux.ibm.com> writes:
> On 17/8/2022 4:15 pm, Jordan Niethe wrote:
>> On Wed, 2022-08-17 at 15:06 +1000, Russell Currey wrote:
>>> From: Nicholas Miehlbradt <nicholas@linux.ibm.com>
>>>
>>> This selftest is designed to cover execute-only protections
>>> on the Radix MMU but will also work with Hash.
>>>
>>> The tests are based on those found in pkey_exec_test with modifications
>>> to use the generic mprotect() instead of the pkey variants.
>> 
>> Would it make sense to rename pkey_exec_test to exec_test and have this test be apart of that?
>> 
> I think might make it unnecessarily complex. The checks needed when 
> testing with pkeys would mean that it would be necessary to check if 
> pkeys are enabled and choose which set of tests to run depending on the 
> result. The differences are substantial enough that it would be 
> challenging to combine them into a single set of tests.

Yeah I think I agree. Having each test stand on its own is nice for
debugging also.

In general I'm less bothered about code duplication in tests. We should
try and share code where we can, but it's more important that we have
tests at all, rather than blocking new tests because they duplicate some
code from another test.

So I'm inclined to merge this as-is, we can always refactor it to share
code in future if we think there's enough commonality to warrant it.

cheers
