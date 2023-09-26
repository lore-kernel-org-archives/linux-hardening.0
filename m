Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302A528DAE
	for <linux-hardening@vger.kernel.org>; Tue, 26 Sep 2023 13:05:10 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E1710A;
	Tue, 26 Sep 2023 06:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695733509; x=1727269509;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=lh+ZilKT0ef/kVO/l7TEDxIiQ8PxnmVHRhAjg11qOtA=;
  b=LOjNuxa1QIteHLFUkODXM2M56CNT0ADrLsphG0znLpTSG49wsVXx+Fll
   D3AYGTh+zqLQbQ/NrHeFUWYh6kwpiKTz6i+xSxaSjhYeJlYGW/0wz49gh
   h8UpcaR2qyWQ0WmDzJ1V0ZJ4K/Gl4+AUUm6NYQcPb9wZJ1bxTGDuhYB38
   jaH6MkqMtbTJuH98FlawjnLm884Qut8EQX7rjqfhcrocDrQf/46XnUTal
   wQek2zf02gWEdvzF8dws/cTv6LTZIkCxJO/gemYBzAyN8ojKPkrJfHiTv
   RiphwBjsbAs3cT24fOLlCPh5x795/jx+KYmkxTX/6x/1e43ACmvDhJmKP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="448055560"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="448055560"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 06:05:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="922409488"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="922409488"
Received: from hongy-mobl.ger.corp.intel.com (HELO localhost) ([10.252.41.3])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 06:05:02 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Jorge Lopez <jorge.lopez2@hp.com>, Kees Cook <keescook@chromium.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
 platform-driver-x86@vger.kernel.org, llvm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
In-Reply-To: <20230922175420.work.701-kees@kernel.org>
References: <20230922175420.work.701-kees@kernel.org>
Subject: Re: [PATCH] platform/x86: hp-bioscfg: Annotate struct bios_args
 with __counted_by
Message-Id: <169573349919.5370.3618409484678821521.b4-ty@linux.intel.com>
Date: Tue, 26 Sep 2023 16:04:59 +0300
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 22 Sep 2023 10:54:21 -0700, Kees Cook wrote:

> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct bios_args.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

Once I've run some tests on the review-ilpo branch the patches
there will be added to the platform-drivers-x86/for-next branch
and eventually will be included in the pdx86 pull-request to
Linus for the next merge-window.

The list of commits applied:
[1/1] platform/x86: hp-bioscfg: Annotate struct bios_args with __counted_by
      commit: 55ec81f7517fad09135f65552cea0a3ee84fff30

--
 i.

