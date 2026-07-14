Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D5E37AA92
	for <linux-hardening@vger.kernel.org>; Tue, 14 Jul 2026 02:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783995973; cv=none; b=SdBMVGakl/aZs9KjwNwOm+Ww6Jy0arxY9oABJ5hxrPgaD6CPi/YJTU7v9C0P5UfN/267H+xF1uTiPCYn20nh0FYH2KuKadrzaZHm0rLTbJTW44WyTRyH5HSotP/Wf4HsEsCOB8Js9Or6bYoTxEHcpMw335hXQbjNrX3ohfINVHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783995973; c=relaxed/simple;
	bh=lKUiJt3APooMI3IqhPxHAhOogKti/18rIw475RmB9uk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=AcrMqeBfRwbUJmfoHva/sjyVslS5MtJuaTyHTRGuewAHbhIkN6Lr51AcRR0iRaaEuiGNlryB4ieRj8nqW+0lsAak5d4TQqOJUZh+UmILZP+hxAIttkqMecc1kRRtBePJWY7MRwBGJFsD69nCGZ3E5OMr+Qow7OKDDV3ZsNcvHkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LXxZo6ik; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LXxZo6ik"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783995966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W9fRwwQkeGf6F9r/P3GuaK/upsaVrmeQr74oaf89FWQ=;
	b=LXxZo6ikKL5FZ163ux6l8K6IjX7k8IwSsHb7dHSp7a3/yd7Fr0eE9O9gdF+lz2OSQsBBD9
	v01jqlH6V8pgCQRalgifB+MISHI0vVZBJLolZotqMWhWmPoQRhSc9FHiRG1gB2BjhQuNyQ
	iiiVTG1vfrCW5//A3brF4RaLXSL5N1U=
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH v6 1/8] mm: fix stale ZONE_DEVICE refcount comment
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20260709112520.24857-2-lizhe.67@bytedance.com>
Date: Tue, 14 Jul 2026 10:25:26 +0800
Cc: akpm@linux-foundation.org,
 apopple@nvidia.com,
 arnd@arndb.de,
 balbirs@nvidia.com,
 bp@alien8.de,
 dave.hansen@linux.intel.com,
 david@kernel.org,
 kees@kernel.org,
 mingo@redhat.com,
 rppt@kernel.org,
 tglx@kernel.org,
 linux-arch@vger.kernel.org,
 linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-mm@kvack.org,
 x86@kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <287F70E5-78F2-4C52-99A4-E72CA16C7635@linux.dev>
References: <20260709112520.24857-1-lizhe.67@bytedance.com>
 <20260709112520.24857-2-lizhe.67@bytedance.com>
To: Li Zhe <lizhe.67@bytedance.com>
X-Migadu-Flow: FLOW_OUT



> On Jul 9, 2026, at 19:25, Li Zhe <lizhe.67@bytedance.com> wrote:
> 
> The comment in __init_zone_device_page() still uses the old
> MEMORY_TYPE_* names and implies that FS_DAX pages regain a
> refcount of 1 in the free path. That no longer matches the code.
> 
> Update the comment to describe the current policy correctly:
> MEMORY_DEVICE_GENERIC pages regain a refcount of 1 in the free path,
> while the remaining ZONE_DEVICE types start from 0 here and raise the
> count again when the allocator or driver hands the page out.
> 
> No functional change intended.
> 
> Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
> Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
> Reviewed-by: Alistair Popple <apopple@nvidia.com>

Reviewed-by: Muchun Song <muchun.song@linux.dev>


