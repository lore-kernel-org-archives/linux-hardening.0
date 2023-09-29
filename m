Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882FA6669B
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 21:27:46 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB92D1B0;
	Fri, 29 Sep 2023 14:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696022864; x=1727558864;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FLVd/ohpJACj32KeVgVSBeUww7ddTyoGFDmzYTsHN9o=;
  b=aaRC5oWhjTqFFABNQGpeWIPUEe/LvrmznLuRVIwkAIfggzGUr2JSlVF0
   qkBCtUpUd1Tk0UWLv6+SZm+z33OytQ7uBFGdKGAOR92TIZx26q7bunxI/
   Q3qVdR5CYE0ZApKwo/J9lsaIL5Xud3gwDaFpNT9QXb1NkhGZG/u5VNNNZ
   okb5YzuFFDJYh4/kclki0jUvv3neVDvzf0uzaumInmO3zj3A4bsQlylpJ
   o+qWVgzNtgp4/9Z47ZgHoHaxLaaVTR24VgzjnRuYuwRB+aOHO6ps34vl2
   fDqhShNOjc0pRxfaW77fUvMIXR/x9BG/x6sICvl+8FKuMA55Th4bIpAo6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="386250138"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="386250138"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 14:27:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="815719573"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="815719573"
Received: from alitchfi-mobl1.amr.corp.intel.com (HELO [10.209.69.33]) ([10.209.69.33])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 14:27:40 -0700
Message-ID: <51164807-4860-b1cc-e3de-4230795808df@intel.com>
Date: Fri, 29 Sep 2023 14:27:39 -0700
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] x86/tdx: refactor deprecated strncpy
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 Nick Desaulniers <ndesaulniers@google.com>
References: <20230911-strncpy-arch-x86-coco-tdx-tdx-c-v1-1-4b38155727f3@google.com>
 <169601242377.3008066.9973846266706309040.b4-ty@chromium.org>
From: Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <169601242377.3008066.9973846266706309040.b4-ty@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/29/23 11:33, Kees Cook wrote:
> On Mon, 11 Sep 2023 18:27:25 +0000, Justin Stitt wrote:
>> `strncpy` is deprecated and we should prefer more robust string apis.
>>
>> In this case, `message.str` is not expected to be NUL-terminated as it
>> is simply a buffer of characters residing in a union which allows for
>> named fields representing 8 bytes each. There is only one caller of
>> `tdx_panic()` and they use a 59-length string for `msg`:
>> |	const char *msg = "TD misconfiguration: SEPT_VE_DISABLE attribute must be set.";
>>
>> [...]
> This appears to be trivially correct, so I can take it via my tree.

Sorry about that, I was being clear as mud as to what I wanted to see
here.  I was hoping for another more clear changelog at least.

The changelog makes it sound like there's a problem with not
NULL-terminating 'message.str' when there isn't.  That makes it hard to
tell what the patch's goals are.

As far as I can tell, the code is 100% correct with either the existing
strncpy() or strtomem_pad(), even with a >64-byte string.  This _is_
unusual because the hypervisor is nice and doesn't require NULL termination.

Would there be anything wrong with a changelog like this?

	strncpy() works perfectly here in all cases.  However, it _is_
	deprecated and unsafe in other cases and there is an effort to
	purge it from the code base to avoid problems elsewhere.

	Replace strncpy() with an equivalent (in this case)
	strtomem_pad() which is not deprecated.

In other words, this fixes no bug.  But we should do it anyway.
