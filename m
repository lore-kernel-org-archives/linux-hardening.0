Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18274C433ED
	for <linux-hardening@archiver.kernel.org>; Thu,  6 May 2021 00:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEF05613B5
	for <linux-hardening@archiver.kernel.org>; Thu,  6 May 2021 00:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhEFABh (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 5 May 2021 20:01:37 -0400
Received: from mga07.intel.com ([134.134.136.100]:25037 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229717AbhEFABh (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 5 May 2021 20:01:37 -0400
IronPort-SDR: jVqDgodxt+kIVk8/aK+SZ/Bwlr/MeetGs2Y94KzKfQoi9AasHDmc5iQ8DNqaccOoEmVFjqm/pw
 7twHrQN0E8xg==
X-IronPort-AV: E=McAfee;i="6200,9189,9975"; a="262275319"
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400"; 
   d="scan'208";a="262275319"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2021 17:00:13 -0700
IronPort-SDR: MiDK5L27NDfnkfqXtcDSsGy9F7Qhs4bjmOfsa/ErInC4zma1y9qyA9ODJsTla/3FvmBKW0Hy6q
 GDYgAOEtWbKw==
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400"; 
   d="scan'208";a="430179714"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2021 17:00:13 -0700
Date:   Wed, 5 May 2021 17:00:13 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org, linux-mm@kvack.org,
        x86@kernel.org, akpm@linux-foundation.org,
        linux-hardening@vger.kernel.org,
        kernel-hardening@lists.openwall.com, rppt@kernel.org,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/9] PKS write protected page tables
Message-ID: <20210506000013.GE1068722@iweiny-DESK2.sc.intel.com>
References: <20210505003032.489164-1-rick.p.edgecombe@intel.com>
 <202105042253.ECBBF6B6@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202105042253.ECBBF6B6@keescook>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, May 04, 2021 at 11:25:31PM -0700, Kees Cook wrote:
> On Tue, May 04, 2021 at 05:30:23PM -0700, Rick Edgecombe wrote:
> 
> > Performance impacts
> > ===================
> > Setting direct map permissions on whatever random page gets allocated for a 
> > page table would result in a lot of kernel range shootdowns and direct map 
> > large page shattering. So the way the PKS page table memory is created is 
> > similar to this module page clustering series[2], where a cache of pages is 
> > replenished from 2MB pages such that the direct map permissions and associated 
> > breakage is localized on the direct map. In the PKS page tables case, a PKS 
> > key is pre-applied to the direct map for pages in the cache.
> > 
> > There would be some costs of memory overhead in order to protect the direct 
> > map page tables. There would also be some extra kernel range shootdowns to 
> > replenish the cache on occasion, from setting the PKS key on the direct map of 
> > the new pages. I don’t have any actual performance data yet.
> 
> What CPU models are expected to have PKS?


Supervisor Memory Protection Keys (PKS) is a feature which is found on Intel’s
Sapphire Rapids (and later) “Scalable Processor” Server CPUs.  It will also be
available in future non-server Intel parts.

Also qemu has some support as well.

https://www.qemu.org/2021/04/30/qemu-6-0-0/

Ira
