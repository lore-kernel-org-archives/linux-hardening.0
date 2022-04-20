Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28B6C433F5
	for <linux-hardening@archiver.kernel.org>; Wed, 20 Apr 2022 23:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351114AbiDTXPU (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 20 Apr 2022 19:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345452AbiDTXPT (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 20 Apr 2022 19:15:19 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B9913DF0;
        Wed, 20 Apr 2022 16:12:31 -0700 (PDT)
Received: (Authenticated sender: joao@overdrivepizza.com)
        by mail.gandi.net (Postfix) with ESMTPA id 1377F100003;
        Wed, 20 Apr 2022 23:12:26 +0000 (UTC)
MIME-Version: 1.0
Date:   Wed, 20 Apr 2022 16:12:26 -0700
From:   Joao Moreira <joao@overdrivepizza.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        peterz@infradead.org, jpoimboe@redhat.com,
        andrew.cooper3@citrix.com, samitolvanen@google.com,
        mark.rutland@arm.com, hjl.tools@gmail.com,
        alyssa.milburn@linux.intel.com, ndesaulniers@google.com,
        gabriel.gomes@linux.intel.com, rick.p.edgecombe@intel.com
Subject: Re: [RFC PATCH 11/11] driver/int3400_thermal: Fix prototype matching
In-Reply-To: <202204201601.8291F550@keescook>
References: <20220420004241.2093-1-joao@overdrivepizza.com>
 <20220420004241.2093-12-joao@overdrivepizza.com>
 <202204191946.2843CF71@keescook>
 <06435f0b44681588052d145a17d60316@overdrivepizza.com>
 <202204201601.8291F550@keescook>
Message-ID: <4dd9a9a3a7fb6f9af0fa04b8d2e3d5a2@overdrivepizza.com>
X-Sender: joao@overdrivepizza.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

> 
> Ah-ha, thanks. I think this will fix it, but I haven't tested it:

I tried that, and IIRC, there was an error or warning in the assignment 
that happens a bit further in the file. My bad for not having it all 
properly tracked.
