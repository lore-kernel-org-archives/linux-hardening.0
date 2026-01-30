Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9787A188713;
	Fri, 30 Jan 2026 01:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769736684; cv=none; b=GCSK5dGaaYuooGkJIchD85zrYHIUFuvOVveZhH6xPRXUnonSSr2uXyfEx3HZtuTe7ujzVdv6YlkiwN3ZdDvjm4lXwOLoYGfVv1b3xjeLhY/bwbbWAezmmOHb92/CLyt+DGdSlpxna8md3oWp9G50pxDaJNrMNyOTsXsZEXCISfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769736684; c=relaxed/simple;
	bh=qnsCsZ4iMqFuDReTCZk4V47d3o0OAD2f+z9JaNVIVLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KCbrQke0c79Luc0ftloSpSQ+QkSZY9gX7nnuRFqKhFmmVgOgveNcDzmNZFwQTvhHk+3qKl4qCfi0uUP94nSw+65XVWmz7cuzc9sqgGdYifYvNHU6JcX7V2MhGCqVNvTPFoGHBN+y1JNORVChKHdqKBFUUECeWgMPEHm+nC/u5ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5c9c9f92fd7b11f0b0f03b4cfa9209d1-20260130
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:f96d8ae5-7807-4359-8513-e1f3641a4faa,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:495220902e48455b3514bc145a626ce2,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|898,TC:nil,Content:0|15|
	50,EDM:-3,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5c9c9f92fd7b11f0b0f03b4cfa9209d1-20260130
X-User: jiangfeng@kylinos.cn
Received: from [10.42.12.56] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <jiangfeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 2005360995; Fri, 30 Jan 2026 09:31:12 +0800
Message-ID: <2d711526-3cee-436a-a563-0d70faf537e2@kylinos.cn>
Date: Fri, 30 Jan 2026 09:31:09 +0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/8] lib/string_kunit: add correctness test for
 strlen()
To: kernel test robot <lkp@intel.com>, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, akpm@linux-foundation.org,
 kees@kernel.org, andy@kernel.org, ebiggers@kernel.org,
 martin.petersen@oracle.com, herbert@gondor.apana.org.au,
 samuel.holland@sifive.com, ajones@ventanamicro.com, charlie@rivosinc.com,
 conor.dooley@microchip.com, linus.walleij@linaro.org, nathan@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20260129070227.220866-2-jiangfeng@kylinos.cn>
 <202601300014.gbv48Y5D-lkp@intel.com>
Content-Language: en-US
From: Feng Jiang <jiangfeng@kylinos.cn>
In-Reply-To: <202601300014.gbv48Y5D-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/1/30 00:55, kernel test robot wrote:
> Hi Feng,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on kees/for-next/hardening]
> [also build test ERROR on akpm-mm/mm-nonmm-unstable akpm-mm/mm-everything linus/master v6.19-rc7 next-20260128]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Feng-Jiang/lib-string_kunit-add-correctness-test-for-strlen/20260129-151036
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
> patch link:    https://lore.kernel.org/r/20260129070227.220866-2-jiangfeng%40kylinos.cn
> patch subject: [PATCH v6 1/8] lib/string_kunit: add correctness test for strlen()
> config: x86_64-randconfig-001-20260129 (https://download.01.org/0day-ci/archive/20260130/202601300014.gbv48Y5D-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260130/202601300014.gbv48Y5D-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202601300014.gbv48Y5D-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>>> lib/tests/string_kunit.c:116:13: error: call to undeclared function 'PAGE_ALIGN'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>      116 |         buf_size = PAGE_ALIGN(STRING_TEST_MAX_LEN + STRING_TEST_MAX_OFFSET + 1);
>          |                    ^
>    1 error generated.
> 
> 
> vim +/PAGE_ALIGN +116 lib/tests/string_kunit.c
> 

Thanks for the report.

I apologize for the build error. This was caused by the missing <linux/mm.h> header
for the PAGE_ALIGN macro in the new test logic. I will include the necessary header
and fix this in the v7 patch set.

>    110	
>    111	static void string_test_strlen(struct kunit *test)
>    112	{
>    113		size_t buf_size;
>    114		char *buf, *s;
>    115	
>  > 116		buf_size = PAGE_ALIGN(STRING_TEST_MAX_LEN + STRING_TEST_MAX_OFFSET + 1);
>    117		buf = vmalloc(buf_size);
>    118		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
>    119	
>    120		memset(buf, 'A', buf_size);
>    121	
>    122		for (size_t offset = 0; offset < STRING_TEST_MAX_OFFSET; offset++) {
>    123			for (size_t len = 0; len <= STRING_TEST_MAX_LEN; len++) {
>    124				s = buf + buf_size - 1 - offset - len;
>    125				s[len] = '\0';
>    126				KUNIT_EXPECT_EQ_MSG(test, strlen(s), len,
>    127					"offset:%zu len:%zu", offset, len);
>    128				s[len] = 'A';
>    129			}
>    130		}
>    131	
>    132		vfree(buf);
>    133	}
>    134	
> 

-- 
With Best Regards,
Feng Jiang

