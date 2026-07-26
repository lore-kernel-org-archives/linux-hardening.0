Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64AF137923;
	Sun, 26 Jul 2026 09:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785056547; cv=none; b=sbn7aOfa+RouqCydtY6eJWzUiNnaXgBdmvUkDjKw7wdgKcwXhhJGNSUyteVFsml2p3iAXjLANuGsDI9kQ31m4NfpZhMN+Y+g30HzZLwb75ca/CHp325gbtiuKOjGoY8iI2W6tSchVeVQyoefs0Sg3ngZ6vOxgo18Pvw9zAjWX2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785056547; c=relaxed/simple;
	bh=H6zc3e+fPKI/5/3sivloek4OyJnOZmoBHY7FinDrAXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o7ZFdzncontEsf/805zxL2IirZzbNiU5Z0rWhxsVATjlSP15tBcejXSsDOxXViHd1kH88ejA6J7/M7auGYRdrQr3ABEYTPMy39iQhWoAynOGYDdrRWhSeViN3pLhyJ5Pzr8XEELQge45r9WDfI968qkNHt+d/e0R1F6WH/00g9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SbvrWYBK; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SbvrWYBK"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1785056533; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=qgDKlgSBwdwNpaUSZa7cKe/JphLs7EoLAwMXrn/+4N8=;
	b=SbvrWYBKN0ygSgnfoLXK0pFNebd8ZQOQAgxxtXFmXyRv1g1famt5npJl6rb/4daIDUlZuwxplLSjSetj9DI5Vj2tFZrDvOwV6XWreHK6O2/rbGoPuSDFvp0HO5GVrPQnXL3LQZWHj4YNjBfmSjsIG7q+GKu2W7PDg16JZ07lVTU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R531e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0X7n9drU_1785056531;
Received: from 30.28.192.31(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X7n9drU_1785056531 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 26 Jul 2026 17:02:12 +0800
Message-ID: <36b3c907-f6f4-4047-b743-04bf1c246e2c@linux.alibaba.com>
Date: Sun, 26 Jul 2026 17:02:11 +0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 RESEND 4/4] selftests: firmware: Add NVIDIA GHES EINJ
 selftest
To: Kai-Heng Feng <kaihengf@nvidia.com>, rafael@kernel.org, shuah@kernel.org,
 kees@kernel.org, "Luck, Tony" <tony.luck@intel.com>
Cc: julianbraha@gmail.com, tony.luck@intel.com, bp@alien8.de,
 guohanjun@huawei.com, mchehab@kernel.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-hardening@vger.kernel.org, csoto@nvidia.com, mochs@nvidia.com
References: <20260724122054.36162-1-kaihengf@nvidia.com>
 <20260724122054.36162-5-kaihengf@nvidia.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20260724122054.36162-5-kaihengf@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/24/26 8:20 PM, Kai-Heng Feng wrote:
> Exercise the full driver path on real Grace and Vera hardware using
> ACPI EINJ to inject CPER sections and validate the kernel log output.
> KUnit covers the parser in isolation; this test covers the path from
> firmware notification through GUID dispatch to decoded output.
> 
> Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>
> ---
> v2:
>   - No change.
> 
>   tools/testing/selftests/firmware/Makefile     |   4 +-
>   tools/testing/selftests/firmware/config       |   5 +
>   tools/testing/selftests/firmware/einj_lib.sh  | 189 ++++++++++++++++++
>   .../selftests/firmware/ghes_nvidia_einj.sh    | 144 +++++++++++++
>   .../firmware/ghes_nvidia_einj_profiles.sh     |  46 +++++
>   5 files changed, 386 insertions(+), 2 deletions(-)
>   create mode 100644 tools/testing/selftests/firmware/einj_lib.sh
>   create mode 100755 tools/testing/selftests/firmware/ghes_nvidia_einj.sh
>   create mode 100755 tools/testing/selftests/firmware/ghes_nvidia_einj_profiles.sh
> 
> diff --git a/tools/testing/selftests/firmware/Makefile b/tools/testing/selftests/firmware/Makefile
> index 7992969deaa2..b753dd123860 100644
> --- a/tools/testing/selftests/firmware/Makefile
> +++ b/tools/testing/selftests/firmware/Makefile
> @@ -3,8 +3,8 @@
>   CFLAGS = -Wall \
>            -O2
>   
> -TEST_PROGS := fw_run_tests.sh
> -TEST_FILES := fw_fallback.sh fw_filesystem.sh fw_upload.sh fw_lib.sh
> +TEST_PROGS := fw_run_tests.sh ghes_nvidia_einj.sh
> +TEST_FILES := fw_fallback.sh fw_filesystem.sh fw_upload.sh fw_lib.sh einj_lib.sh ghes_nvidia_einj_profiles.sh
>   TEST_GEN_FILES := fw_namespace

I am not sure this belongs in the generic firmware selftests.

This test requires root, debugfs, ACPI EINJ, NVIDIA-specific vendor EINJ
metadata, a bound NVDA2012 device, and it writes EINJ controls before
triggering error_inject.  Even if the selected profiles are intended to be
informational, this looks more like a platform RAS validation tool than a
generic kselftest that should run as part of the firmware selftest suite.

Would ras-tools be a better place for this?  Tony Luck maintains that tree
for RAS-related test and injection tooling, and this script seems to fit
there better than tools/testing/selftests/firmware/.

Please see:

     https://git.kernel.org/pub/scm/linux/kernel/git/aegl/ras-tools.git

Thanks,
Shuai
