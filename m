Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F21B2DE6F9;
	Wed,  2 Jul 2025 20:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751488121; cv=none; b=eJAUJQH8h5YzQ43FDyMKPy2yuBZvk6RCmC0S3cRNi5s1Kq4mYAJ0Yc9CxE1RoOnBWukhrxxfxP1q3CVb6cVuv2FMKyNRxF47jaoKqaVXXfHrm8mZvkw6soKaDtCTvDBllUfezqj8V+J9IE+fCF5qIWOz8yJ3ssVtSpbZ1+EU7K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751488121; c=relaxed/simple;
	bh=ROkGUzLvmUxE4wznrKVXwS7nEdwLuTZhM5xIYa2wHvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ucbl5XeAUXHBBApXo1cM7QUh9jSy8lzxU+ZXvkRAHirx8VRaEfmtZi1vxlY01WNfU9Tm6SxRAXYjveVp5qNZjSSRHGymqzDD/hqYQqr8oalfQ4ID7KvRwzfbrJofP0OcIx3lTqwayBF14ieePCKutG+rhSDmjgBNK4HVNmTCU28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKKea4et; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKKea4et"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82657C4CEEE;
	Wed,  2 Jul 2025 20:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751488121;
	bh=ROkGUzLvmUxE4wznrKVXwS7nEdwLuTZhM5xIYa2wHvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OKKea4etTumn63tPGWaQhMxfzqNeH9R22N6OU2sVXEmAQoLTSRbusDooxkfv79rmL
	 L1MAbj1ez+//gH4n6cns1sUnhqFlb3IOEtzo7q6SR0k/ZtMhoH8Rnp1hizQAnUtnAe
	 MpwyNAmRBKmYQDJdgoI1wYwextBTsIh7MaShy/i8Tj4j2nYMGUZZxrLftkxNjHznAr
	 72DyRBXxmru0h01OAlJH6ojuHmNffvgqb1KE/Ug+n9GroPojQHz6pUwL5MFgODaYKj
	 N3gtEfr89+/xXR2TVrGpx1hXQHCXfQttdnUWBwDeGNzsXHjxXKDDx51m8+XTkskrYr
	 /HuR5UQo7HgVQ==
Date: Wed, 2 Jul 2025 13:28:35 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Petr Mladek <pmladek@suse.com>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	David Gow <davidgow@google.com>, Arnd Bergmann <arnd@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/3] printk: kunit: support offstack cpumask
Message-ID: <20250702202835.GA593751@ax162>
References: <20250702095157.110916-1-pmladek@suse.com>
 <20250702095157.110916-3-pmladek@suse.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702095157.110916-3-pmladek@suse.com>

On Wed, Jul 02, 2025 at 11:51:56AM +0200, Petr Mladek wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> For large values of CONFIG_NR_CPUS, the newly added kunit test fails
> to build:
> 
> kernel/printk/printk_ringbuffer_kunit_test.c: In function 'test_readerwriter':
> kernel/printk/printk_ringbuffer_kunit_test.c:279:1: error: the frame size of 1432 bytes is larger than 1280 bytes [-Werror=frame-larger-than=]
> 
> Change this to use cpumask_var_t and allocate it dynamically when
> CONFIG_CPUMASK_OFFSTACK is set.
> 
> Fixes: 5ea2bcdfbf46 ("printk: ringbuffer: Add KUnit test")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> [pmladek@suse.com: Correctly handle allocation failures and freeing using KUnit test API.]
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>  kernel/printk/printk_ringbuffer_kunit_test.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/printk/printk_ringbuffer_kunit_test.c b/kernel/printk/printk_ringbuffer_kunit_test.c
> index 217dcc14670c..0c3030fde8c2 100644
> --- a/kernel/printk/printk_ringbuffer_kunit_test.c
> +++ b/kernel/printk/printk_ringbuffer_kunit_test.c
> @@ -216,6 +216,7 @@ static int prbtest_reader(struct prbtest_data *test_data, unsigned long timeout_
>  	return 0;
>  }
>  
> +KUNIT_DEFINE_ACTION_WRAPPER(prbtest_cpumask_cleanup, free_cpumask_var, cpumask_var_t);

This appears to break the build for me when CONFIG_CPUMASK_OFFSTACK is not
set, like when enabling this test on top of x86_64 defconfig:

  In file included from kernel/printk/printk_ringbuffer_kunit_test.c:14:
  kernel/printk/printk_ringbuffer_kunit_test.c: In function 'prbtest_cpumask_cleanup':
  include/kunit/resource.h:409:32: error: cast specifies array type
    409 |                 arg_type arg = (arg_type)in;                    \
        |                                ^
  kernel/printk/printk_ringbuffer_kunit_test.c:226:1: note: in expansion of macro 'KUNIT_DEFINE_ACTION_WRAPPER'
    226 | KUNIT_DEFINE_ACTION_WRAPPER(prbtest_cpumask_cleanup, free_cpumask_var, cpumask_var_t);
        | ^~~~~~~~~~~~~~~~~~~~~~~~~~~

Clang's error might be a little clearer with the "aka" note it provides.

  kernel/printk/printk_ringbuffer_kunit_test.c:226:1: error: used type 'cpumask_var_t' (aka 'struct cpumask[1]') where arithmetic or pointer type is required
    226 | KUNIT_DEFINE_ACTION_WRAPPER(prbtest_cpumask_cleanup, free_cpumask_var, cpumask_var_t);
        | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  include/kunit/resource.h:409:18: note: expanded from macro 'KUNIT_DEFINE_ACTION_WRAPPER'
    409 |                 arg_type arg = (arg_type)in;                    \
        |                                ^         ~~

>  KUNIT_DEFINE_ACTION_WRAPPER(prbtest_kthread_cleanup, kthread_stop, struct task_struct *);
>  
>  static void prbtest_add_kthread_cleanup(struct kunit *test, struct task_struct *kthread)
> @@ -240,8 +241,13 @@ static void test_readerwriter(struct kunit *test)
>  	struct prbtest_thread_data *thread_data;
>  	struct prbtest_data *test_data;
>  	struct task_struct *thread;
> -	cpumask_t test_cpus;
> +	cpumask_var_t test_cpus;
>  	int cpu, reader_cpu;
> +	int err;
> +
> +	KUNIT_ASSERT_TRUE(test, alloc_cpumask_var(&test_cpus, GFP_KERNEL));
> +	err = kunit_add_action_or_reset(test, prbtest_cpumask_cleanup, test_cpus);
> +	KUNIT_ASSERT_EQ(test, err, 0);
>  
>  	cpus_read_lock();
>  	/*
> @@ -250,15 +256,15 @@ static void test_readerwriter(struct kunit *test)
>  	 * Instead use a snapshot of the online CPUs.
>  	 * If they change during test execution it is unfortunate but not a grave error.
>  	 */
> -	cpumask_copy(&test_cpus, cpu_online_mask);
> +	cpumask_copy(test_cpus, cpu_online_mask);
>  	cpus_read_unlock();
>  
>  	/* One CPU is for the reader, all others are writers */
> -	reader_cpu = cpumask_first(&test_cpus);
> -	if (cpumask_weight(&test_cpus) == 1)
> +	reader_cpu = cpumask_first(test_cpus);
> +	if (cpumask_weight(test_cpus) == 1)
>  		kunit_warn(test, "more than one CPU is recommended");
>  	else
> -		cpumask_clear_cpu(reader_cpu, &test_cpus);
> +		cpumask_clear_cpu(reader_cpu, test_cpus);
>  
>  	/* KUnit test can get restarted more times. */
>  	prbtest_prb_reinit(&test_rb);
> @@ -271,7 +277,7 @@ static void test_readerwriter(struct kunit *test)
>  
>  	kunit_info(test, "running for %lu ms\n", runtime_ms);
>  
> -	for_each_cpu(cpu, &test_cpus) {
> +	for_each_cpu(cpu, test_cpus) {
>  		thread_data = kunit_kmalloc(test, sizeof(*thread_data), GFP_KERNEL);
>  		KUNIT_ASSERT_NOT_NULL(test, thread_data);
>  		thread_data->test_data = test_data;
> -- 
> 2.50.0
> 
