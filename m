Received: from va-1-115.ptr.blmpb.com (va-1-115.ptr.blmpb.com [209.127.230.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E502838886B
	for <linux-hardening@vger.kernel.org>; Thu, 30 Jul 2026 07:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785398034; cv=none; b=p0OMzIVtPialrq0eoPUR+wjn6znPyEs/sljzvx8FPRK25ylOL9UQde/e3Hhf1SCfcEyh+o73ginjC5ahRslcKp54sjjlEoiy002ytFiQUFw59aVl0XPfOHIeRma4+m7NuS950CcgkuPBrl72q1RkCsxEHIpxd4LKwbiP5Ut/KrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785398034; c=relaxed/simple;
	bh=i8v0CBrzuIg3GbnT2uYqPiocpv9EQhDpNnWNDIDzVjY=;
	h=Subject:Message-Id:References:In-Reply-To:To:Cc:Content-Type:From:
	 Date:Mime-Version; b=c0wB7he0Y+p3lWzyDO9MPCINwpopaJ5pG33GOSC7h6U1loy426HElTQ4T4l99iYPC/RF98RNX1mG5YsUN/96UiWJCDrUlRohv6uUYwdJUSZQUoGCDhRsxJykoCzehYkiAmah5b/OTwHfUexguJu/x0iBjtSIVnRe6+PUMSUKnK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=RjSfmdGh; arc=none smtp.client-ip=209.127.230.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="RjSfmdGh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1785398026; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=i8v0CBrzuIg3GbnT2uYqPiocpv9EQhDpNnWNDIDzVjY=;
 b=RjSfmdGhXl6kJy5B7OsKQcA1tZ8lodkG5GTBe7dQU1LcClfaf5UIH1jE3/lxx1eEydI028
 XRMnFwfzxivY4g9SFdBPx+ZNlRdEhUc+PEB4KNIawXTe9wvFGGrR3jfojwGH61ARYebqZb
 o6aTc26p2KlYVm9aMvbjiy15FOr2OpxGwwCu5TjkPzs6LnZVu+zp0ougjGfAwGPKf9QdN2
 hZ/ZZ+UdSzXdB/T2pSj7akzgQ3WdywzJ4wYGM2ms82NgYSymcIx16sp75u24HwsbVksdAz
 pIKXY4kEAW5Xr1Mou/oAHEQwub8RILSAZF5DVpEk4kNkYAN5JvpReCpUYQ8eNA==
Subject: Re: [PATCH v7 0/9] mm: optimize zone-device memmap initialization
Message-Id: <d68f7091-60ae-4887-88f0-42f4288b8e52@bytedance.com>
References: <20260720120259.1545-1-lizhe.67@bytedance.com> <20260720120259.1545-2-lizhe.67@bytedance.com> <178525732062.1556190.314794914123127147.b4-review@b4>
In-Reply-To: <178525732062.1556190.314794914123127147.b4-review@b4>
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
To: "Mike Rapoport" <rppt@kernel.org>
Cc: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<balbirs@nvidia.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>, 
	<david@kernel.org>, <kees@kernel.org>, <mingo@redhat.com>, 
	<tglx@kernel.org>, <muchun.song@linux.dev>, <linux-arch@vger.kernel.org>, 
	<linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<linux-mm@kvack.org>, <x86@kernel.org>
Content-Transfer-Encoding: 7bit
User-Agent: Mozilla Thunderbird
Content-Type: text/plain; charset=UTF-8
From: "Li Zhe" <lizhe.67@bytedance.com>
Date: Thu, 30 Jul 2026 15:53:22 +0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26a6b0308+4629c6+vger.kernel.org+lizhe.67@bytedance.com>

On 7/29/26 12:48 AM, Mike Rapoport wrote:
>> The numbers below measure the time spent in memmap_init_zone_device()
>> during driver bind/rebind. They are not measurements of the full
>> nd_pmem or dax_pmem bind/rebind operation.
>>
>> Tested in a VM with a 100 GB fsdax namespace device configured with
>> map=dev and a 100 GB devdax namespace (align=2097152) on Intel Ice Lake
>> server.
> Since the first pathes touch the generic part of the memory map
> initialization, it would be nice to make sure they don't regress other
> architectures.


Thanks for pointing this out.

I was able to get temporary access to an arm64 environment and have
tested the generic template changes there as well. I will add the arm64
test result to the v9 cover letter.

Thanks,
Zhe
