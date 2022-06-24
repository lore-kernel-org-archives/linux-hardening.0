Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0920CC433EF
	for <linux-hardening@archiver.kernel.org>; Fri, 24 Jun 2022 13:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbiFXNUI (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 24 Jun 2022 09:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbiFXNUH (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 24 Jun 2022 09:20:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D64954FBD
        for <linux-hardening@vger.kernel.org>; Fri, 24 Jun 2022 06:20:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E8E061F00
        for <linux-hardening@vger.kernel.org>; Fri, 24 Jun 2022 13:20:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEB15C34114;
        Fri, 24 Jun 2022 13:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656076804;
        bh=MEsGlL3F/sq2A1ko6y914k6bF1dtF6Taeh6a52h3eGo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KQ0v4jB7KIwa4tTa6Y4LQuGR6c4qitZwAb2uGtoyV+rkOITdv3b6lFk4ZwL1w+Ij6
         vwWj90o479WkG57ikwruokqIO7SaNf46e9wis3D3nKq1C6V3RLCyZcz3M1H5gOl5VC
         Kr9cFtpZ6adWGb0dUN900PbRREHOXo3CXTwn+3YnZoPP5UtdCP0rY6Ov73uDbnAdEy
         dvUR+781V776D8yiE5tmmHRhgMh4tUw/YU8jyH0QT+Uhr6mSRhRI0CHSq/GRdil3n3
         CCATtxsUXbTqi6JRkdVuFN5TRuMSocfiStiEklBucw3rdmHTN6wYJM41sk4FBa/VR5
         R4dpT9M9rG9dw==
Date:   Fri, 24 Jun 2022 14:19:59 +0100
From:   Will Deacon <will@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-hardening@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v4 00/26] arm64: refactor boot flow and add support for
 WXN
Message-ID: <20220624131958.GG18561@willie-the-truck>
References: <20220613144550.3760857-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613144550.3760857-1-ardb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi Ard,

On Mon, Jun 13, 2022 at 04:45:24PM +0200, Ard Biesheuvel wrote:
> [ TL;DR this series does the following:
>   - move variable definitions and assignments out of early asm code
>     where possible, and get rid of explicit cache maintenance;
>   - convert initial ID map so it covers the entire loaded image as well
>     as the DT blob;
>   - create the kernel mapping only once instead of twice (for KASLR),
>     and do it with the MMU and caches on;
>   - avoid mappings that are both writable and executable entirely;
>   - avoid parsing the DT while the kernel text and rodata are still
>     mapped writable;
>   - allow WXN to be enabled (with an opt-out) so writable mappings are
>     never executable. ]

I really like this series -- it removes quite a few ugly warts from our
boot assembly that we've collected over the years and, while functional,
they have never been particularly satisfactory. Thank you for putting it
together.

I've left a handful of minor comments on some of the patches and if you
can address those then I'd like to queue the first 21 patches ASAP to
give them some more exposure before the next merge window.

The remaining patches are the WXN pieces, which I'd like to give others
a chance to chime in on first.

Cheers,

Will
