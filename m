Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266B6C19F2B
	for <linux-hardening@archiver.kernel.org>; Thu,  4 Aug 2022 10:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbiHDKmG (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 4 Aug 2022 06:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiHDKmE (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 4 Aug 2022 06:42:04 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558A42AC54;
        Thu,  4 Aug 2022 03:42:03 -0700 (PDT)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id 5B95740D403D;
        Thu,  4 Aug 2022 10:41:58 +0000 (UTC)
MIME-Version: 1.0
Date:   Thu, 04 Aug 2022 13:41:58 +0300
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        linux-hardening@vger.kernel.org
Subject: Re: [RFC PATCH 0/8] x86_64: Harden compressed kernel, part 1
In-Reply-To: <973736db-2480-bbaa-d2ce-6e1b6dd2ed0c@intel.com>
References: <cover.1659369873.git.baskov@ispras.ru>
 <e6e7fef1-0dff-ef72-8a17-8ecec89994ca@intel.com>
 <893da11995f93a7ea8f7485d17bf356a@ispras.ru>
 <e8342722-20f8-a566-59c5-8e8f7f271d98@intel.com>
 <29312ea704885f1b8d3c229e1f22dad7@ispras.ru>
 <973736db-2480-bbaa-d2ce-6e1b6dd2ed0c@intel.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <09c1c94fb9c5006199d88caa88f237a3@ispras.ru>
X-Sender: baskov@ispras.ru
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 2022-08-03 17:05, Dave Hansen wrote:
> 
> That shows me that it's _possible_ to build a more strict PE loader 
> that
> wouldn't load Linux.  But, in practice is anyone using a more strict PE
> loader?  Does anyone actually want that in practice?  Or, again, is 
> this
> more strict PE loader just an academic demonstration?
> 
> The README starts:
> 
> 	This branch demonstrates...
> 
> That doesn't seem like something that's _important_ to deal with.
> Sounds like a proof-of-concept.
> 
> Don't get me wrong, I'm all for improving thing, even if the benefits
> are far off.  But, let's not fool ourselves.

We have commercial closed-source UEFI firmware implementation at ISP RAS
that follows the behavior of the secure_pe branch. That firmware is used
as a part of [1].

[1] https://www.ispras.ru/en/technologies/asperitas/

Thanks,
Evgeniy Baskov
