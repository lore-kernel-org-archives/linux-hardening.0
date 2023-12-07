Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2913122;
	Thu,  7 Dec 2023 04:50:54 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="480411733"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="480411733"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 04:50:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="800717843"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="800717843"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 04:50:51 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1rBDq3-00000002bNc-0J0l;
	Thu, 07 Dec 2023 14:50:47 +0200
Date: Thu, 7 Dec 2023 14:50:46 +0200
From: Andy Shevchenko <andy@kernel.org>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Greg KH <greg@kroah.com>, Al Viro <viro@zeniv.linux.org.uk>,
	tanzirh@google.com, Kees Cook <keescook@chromium.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nick DeSaulniers <nnn@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, llvm@lists.linux.dev
Subject: Re: [PATCH] lib/string: shrink lib/string.i via IWYU
Message-ID: <ZXG_pumoDp88qIuw@smile.fi.intel.com>
References: <20231205-libstringheader-v1-1-7f9c573053a7@gmail.com>
 <20231205213807.GE1674809@ZenIV>
 <CAKwvOd=2VASkaLvjU+7kkbvhu2CimYn5KUGJBDRePyUhtrNK2Q@mail.gmail.com>
 <2023120608-ivy-snowdrop-890d@gregkh>
 <CAKwvOdmFJ=ZGN8ZScS5oQpXnAL0wwtTDCeNNGpBKZXzQ4kRAVA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOdmFJ=ZGN8ZScS5oQpXnAL0wwtTDCeNNGpBKZXzQ4kRAVA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Dec 05, 2023 at 02:14:55PM -0800, Nick Desaulniers wrote:
> On Tue, Dec 5, 2023 at 1:59 PM Greg KH <greg@kroah.com> wrote:

...

> For example, lib/math/int_log.c includes asm/bug.h.  Is that a case
> where lib/math/int_log.c should be #include 'ing linux/bug.h rather
> than asm/bug.h?

For the C-files it's fine to include linux/* versions of asm/* ones,
for the _headers_ I would prefer to be strictly minimalistic, because
of possible header dependency hell. If something is defined in asm/*
and some header wants to use that, it's better to include asm/*.

-- 
With Best Regards,
Andy Shevchenko


