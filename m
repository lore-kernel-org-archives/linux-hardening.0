Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF657FD;
	Fri,  7 Feb 2025 04:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738903953; cv=none; b=McdZMGd/6V7F0l9xWL2tS+mZY21ho3SJf1qj6PwQIHXSF/8vOFjhSD292R0/T1J6LcalXjSVRl92xPP8DxNdUecTo4FdatpW13UZlxx8haFsHAKZYKrS5qDywEdCHWIEBAQ+4U72LyOoFKsnO24EHo6kxjBWqXKXouaInCvsCuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738903953; c=relaxed/simple;
	bh=DHjArMeAK3MeqFPs8ewPHAdYTmkFt/+F2+q7rMjVEsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XE6cL20gdKOnT1Grn6e2wAAC71Ke/gq5PoTSVJkEwm0CPXBi5qyn30FuGUS8FZeBUAwz3vT7IAADe0J6yjQtD0hac0hA4oi77xJld9c+zaeWOEp3iMlBaBLUPOafrAz+QW3mBuFU3WXTDNuM8twpHgU9sNt1140ufDG+HMfaZVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4hOTD94; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4hOTD94"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1AC9C4CED1;
	Fri,  7 Feb 2025 04:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738903952;
	bh=DHjArMeAK3MeqFPs8ewPHAdYTmkFt/+F2+q7rMjVEsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J4hOTD940F1xlXDm0mc5K3mDWMF8PSxayTzbGZ7yFgncZQhreabSjsW/SPkrxvWyj
	 nSL6ezpoAY094IRO9xVo7ABLzhV1eguxz++lt/TzXCZ8K45nVXR4iXLQO5O5OvWp0K
	 ATK9xHVbtmFdnug59ERW+h66BXmzxYNeXv29CdAsmMdv00eYEe0sd6vVofADQf05te
	 lT0NWx4WrW5hPsI8JfAq6/8JcdwZWb3xVM2NWlDEGMKosdaJAlWafYQrvED6iGX8qh
	 kmzhADTz8zfNueFUjkLH68uqsQf0kpB9zw+24EnTrALzamINKTukN0O7a9JCGIPQDt
	 St5IHezNhourg==
Date: Thu, 6 Feb 2025 20:52:32 -0800
From: Kees Cook <kees@kernel.org>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Howells <dhowells@redhat.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@chromium.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andy Lutomirski <luto@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Pierre Langlois <pierre.langlois@arm.com>,
	Quentin Perret <qperret@google.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	x86@kernel.org
Subject: Re: [RFC PATCH 8/8] mm: Add basic tests for kpkeys_hardened_cred
Message-ID: <202502062024.BCB0DED1D5@keescook>
References: <20250203102809.1223255-1-kevin.brodsky@arm.com>
 <20250203102809.1223255-9-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203102809.1223255-9-kevin.brodsky@arm.com>

On Mon, Feb 03, 2025 at 10:28:09AM +0000, Kevin Brodsky wrote:
> Add basic tests for the kpkeys_hardened_pgtables feature: try to
> perform a direct write to current->{cred,real_cred} and ensure it
> fails.
> 
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> ---
>  mm/Makefile                    |  1 +
>  mm/kpkeys_hardened_cred_test.c | 42 ++++++++++++++++++++++++++++++++++

Current file naming convention[1] would be to name this as:

	mm/tests/kpkeys_hardened_cred_kunit.c

>  security/Kconfig.hardening     | 11 +++++++++
>  3 files changed, 54 insertions(+)
>  create mode 100644 mm/kpkeys_hardened_cred_test.c
> 
> diff --git a/mm/Makefile b/mm/Makefile
> index f7263b7f45b8..2024226902d4 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -149,3 +149,4 @@ obj-$(CONFIG_TMPFS_QUOTA) += shmem_quota.o
>  obj-$(CONFIG_PT_RECLAIM) += pt_reclaim.o
>  obj-$(CONFIG_KPKEYS_HARDENED_PGTABLES) += kpkeys_hardened_pgtables.o
>  obj-$(CONFIG_KPKEYS_HARDENED_PGTABLES_TEST) += kpkeys_hardened_pgtables_test.o
> +obj-$(CONFIG_KPKEYS_HARDENED_CRED_TEST) += kpkeys_hardened_cred_test.o

And for the Kconfig convention says[2] this should be:

	CONFIG_KPKEYS_HARDENED_CRED_KUNIT_TEST

> diff --git a/mm/kpkeys_hardened_cred_test.c b/mm/kpkeys_hardened_cred_test.c
> new file mode 100644
> index 000000000000..46048098f99d
> --- /dev/null
> +++ b/mm/kpkeys_hardened_cred_test.c
> @@ -0,0 +1,42 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <kunit/test.h>
> +#include <linux/sched.h>
> +
> +static void write_cred(struct kunit *test)
> +{
> +	long zero = 0;
> +	int ret;
> +
> +	ret = copy_to_kernel_nofault((unsigned long *)current->cred, &zero, sizeof(zero));
> +	KUNIT_EXPECT_EQ_MSG(test, ret, -EFAULT,
> +			    "Write to current->cred wasn't prevented");
> +
> +	ret = copy_to_kernel_nofault((unsigned long *)current->real_cred, &zero, sizeof(zero));
> +	KUNIT_EXPECT_EQ_MSG(test, ret, -EFAULT,
> +			    "Write to current->real_cred wasn't prevented");

This is a good negative test. I would include a positive test as well.
i.e. make sure you can run copy_from_kernel_nofault() to read it
successfully. Otherwise you don't know if you're just getting a bad
address -- we want to distinguish between them. (This is more true for
the next suggestion, since current->cred being broken would be much more
obvious.)

While current->cred is good and easy, I would like to see prepare_creds()
exercised too to get a new cred and validate that it is equally directly
readable and directly not writable, and then use the correct accessors
to perform a successful write to the cred, read back the change,
etc. (i.e. validate the expected behavior too.)

> +}
> +
> +static int kpkeys_hardened_cred_suite_init(struct kunit_suite *suite)
> +{
> +	if (!arch_kpkeys_enabled()) {
> +		pr_err("Cannot run kpkeys_hardened_cred tests: kpkeys are not supported\n");
> +		return 1;
> +	}

Instead of failing ("return 1") I think this should be a "skip" (it is
expected to not work if there is no support) in each test instead:

	if (!arch_kpkeys_enabled())
		kunit_skip(test, "kpkeys are not supported\n");

I'm very happy to see tests! :)

-Kees

[1] https://docs.kernel.org/dev-tools/kunit/style.html#test-file-and-module-names
[2] https://docs.kernel.org/dev-tools/kunit/style.html#test-kconfig-entries

-- 
Kees Cook
