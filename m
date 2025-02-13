Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E38E1C07C3;
	Thu, 13 Feb 2025 14:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739458490; cv=none; b=h2E4TV5TJGOqWBnP81coFg/SjtBOjAD5k8KMvgOMLNGFJTwN9JBKnN5ypnmCXfEV1XNt31dUYHyH2awofrIWDULV4w2gw8k3BShVOzO0Elz1k229msHyPE7JCADDZOCsnEHwzrZfYnJczk08MfRyj3llqMZRs015aI+hqsRBSr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739458490; c=relaxed/simple;
	bh=IfuxON9f1+mt0J5dXUHTZ8LLFpSbXwaRfsyQDzivT8Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=UJrM0RBeevITjjeqUjjHl4dQljGs6DLenBg39/+qlANSNvHiiS0p5EgPRwAvveqwcyas4QiFHtEVFbCfgX0TOn3ljCz4aAT1A9kqGiFwhFVLAUtcUl7C2WKG12Bo6gBPGxg0eCy0G63Mf6FZY5d8OJ+YBSCh7vSOgFsMm3XPW6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C074106F;
	Thu, 13 Feb 2025 06:55:08 -0800 (PST)
Received: from [10.44.160.94] (e126510-lin.lund.arm.com [10.44.160.94])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 677FC3F58B;
	Thu, 13 Feb 2025 06:54:42 -0800 (PST)
Message-ID: <c16a24b9-1258-4976-827d-db3335bf6e83@arm.com>
Date: Thu, 13 Feb 2025 15:54:40 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 00/15] pkeys-based page table hardening
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: Kees Cook <kees@kernel.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Mark Brown <broonie@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Jann Horn <jannh@google.com>,
 Jeff Xu <jeffxu@chromium.org>, Joey Gouly <joey.gouly@arm.com>,
 Linus Walleij <linus.walleij@linaro.org>, Andy Lutomirski <luto@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Pierre Langlois <pierre.langlois@arm.com>,
 Quentin Perret <qperret@google.com>, "Mike Rapoport (IBM)"
 <rppt@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Qi Zheng <zhengqi.arch@bytedance.com>,
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, x86@kernel.org
References: <20250203101839.1223008-1-kevin.brodsky@arm.com>
 <202502061422.517A57F8@keescook>
 <fd101c51-d3fc-4a4f-afcc-364b8d3c4a0b@arm.com>
Content-Language: en-GB
In-Reply-To: <fd101c51-d3fc-4a4f-afcc-364b8d3c4a0b@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/02/2025 15:23, Kevin Brodsky wrote:
> [...]
>
>>> Any comment or feedback will be highly appreciated, be it on the
>>> high-level approach or implementation choices!
>> As hinted earlier with my QEMU question... what's the best way I can I
>> test this myself? :)
> As mentioned above I tested this series on Arm FVP. By far the easiest
> way to run some custom kernel/rootfs on FVP is to use the Shrinkwrap
> tool [3]. First install it following the quick start guide [4] (I would
> recommend using the Docker backend if possible). Then build the firmware
> stack using:
>
> $ shrinkwrap build -o arch/v9.0.yaml ns-edk2.yaml
>
> To make things easy, the runtime configuration can be stored in a file.
> Create ~/.shrinkwrap/config/poe.yaml with the following contents:
>
> ----8<----
>
> %YAML 1.2
> ---
> layers:
>   - arch/v9.0.yaml

Apologies, this is incorrect - it will not work with the most recent FVP
builds. POE is a v9.4 feature so this line should be replaced with:

> - arch/v9.4.yaml

(No need to change the shrinkwrap build line, it only matters for the
FVP runtime parameters.)

- Kevin

> run:
>   rtvars:
>     CMDLINE:
>       type: string
>       # nr_cpus=1 can be added to speed up the boot
>       value: console=ttyAMA0 earlycon=pl011,0x1c090000 root=/dev/vda rw
>   params:
>     -C cluster0.has_permission_overlay_s1: 1
>     -C cluster1.has_permission_overlay_s1: 1
>
> ----8<----
>
> Finally start FVP using:
>
> $ shrinkwrap run -o poe.yaml ns-edk2.yaml -r
> KERNEL=<out>/arch/arm64/boot/Image -r ROOTFS=<rootfs.img>
>
> (Use Ctrl-] to terminate the model if needed.)
>
> <rootfs.img> is a file containing the root filesystem (in raw format,
> e.g. ext4). The kernel itself is built as usual (defconfig works just
> fine), just make sure to select CONFIG_KPKEYS_HARDENED_PGTABLES to
> enable the feature. You can also select
> CONFIG_KPKEYS_HARDENED_PGTABLES_TEST to run the tests in patch 15.
