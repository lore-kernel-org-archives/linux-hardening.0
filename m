Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81057182C3
	for <linux-hardening@vger.kernel.org>; Mon,  9 Oct 2023 12:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fUDPshpf"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6699499;
	Mon,  9 Oct 2023 05:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696854519; x=1728390519;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RfddNvi5x0wejZG5QzaCfI3Qcz87rv0fDzUvwx9WuLY=;
  b=fUDPshpfWyU0gstdvmwc7yu5vRQjt5H8WEwzNEyynd1VWg/F4XMp6Qhy
   Y7JOYJpT5EZv8imQGi8sv5IPX3QxVx6e6aZGjP5o9zimyj7r2jYMGp4UY
   tfeF0n3CxHlz9nCS1MG9uLfYC8Mb2/R+sy5zcrevYcRVWCnnmHG5ohvnB
   Kylf0jTO1+G3MruC70DrSnfFsOEkF39xiMdLUu3u/AU9la93Qa6FSLIYC
   5NofFMSgsLm78Daos+ZIopxmRZHdDbIHGPPeLMgpruFJQdnHTtL5bMeZI
   6aTM4zBVNqGJGFfwZPrzxQd3VxQrOXdL/pqDHihIsw8oOQ8j2laPNDUsW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="384004945"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="384004945"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 05:28:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="746656325"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="746656325"
Received: from ibrahim2-mobl2.gar.corp.intel.com (HELO intel.com) ([10.213.42.185])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 05:28:26 -0700
Date: Mon, 9 Oct 2023 14:28:20 +0200
From: Andi Shyti <andi.shyti@linux.intel.com>
To: Kees Cook <keescook@chromium.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	John Harrison <John.C.Harrison@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-hardening@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>, Andi Shyti <andi.shyti@linux.intel.com>,
	Nirmoy Das <nirmoy.das@intel.com>,
	Jonathan Cavitt <jonathan.cavitt@intel.com>,
	Fei Yang <fei.yang@intel.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] drm/i915/guc: Annotate struct ct_incoming_msg with
 __counted_by
Message-ID: <ZSPx5OrMBm0O6wpL@ashyti-mobl2.lan>
References: <20231006201744.work.135-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006201744.work.135-kees@kernel.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Kees,

On Fri, Oct 06, 2023 at 01:17:45PM -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct ct_incoming_msg.
> 
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: John Harrison <John.C.Harrison@Intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>
> Cc: Matt Roper <matthew.d.roper@intel.com>
> Cc: intel-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-hardening@vger.kernel.org
> Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
> Signed-off-by: Kees Cook <keescook@chromium.org>

merged in drm-intel-gt-next.

Thanks,
Andi
