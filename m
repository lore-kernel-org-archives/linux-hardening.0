Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7402CA8;
	Sat, 28 Sep 2024 21:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727559333; cv=none; b=ii4DuPzZNPe465dhnn+GfzX8t7hecb/V4sQMsOXOE/VumSFUFdC2WTN4NC7Nk8bkYTNUQlLIXLnH8K8v81I+nCCsAJ1UqFoYl8EPmpWvxZ5ibvMEU2mo4vtbh7Rb9PUtBZ30eJ8zrrbKoS/BjHT6GCIYYDWKCEXQVOX0mRxdWSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727559333; c=relaxed/simple;
	bh=fcEkLdSn97uf948OebI1abOEWs5PxOZtBFstouk1D2g=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=tZHBB7z3EYBXp4oT7BaVBcf4Yk95MTTpZP1ffBnAAu/ZrLuWUH8pRXibJbeed4q2H1RDBoUWjxkUZkrRAi0H3yDmzmMHp2/sg4bTaT4k3+IPIMYznMRLSY5nCyWrvRGP/0VlHjxh8yYg3n+k/xBhETAp6kWWwh8nk0ohdbwCcZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=01nqsylJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="01nqsylJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE6D0C4CEC3;
	Sat, 28 Sep 2024 21:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1727559333;
	bh=fcEkLdSn97uf948OebI1abOEWs5PxOZtBFstouk1D2g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=01nqsylJsJsI2ZhU5BjfgKOASkC/uMX85LRDGL5h6VL4O0bVN3/wfl5Ay9iKnVH0c
	 EzVh27SU4U7qmu+OErp/lhrgs+mVaNX3NEJFQum+jvjTz5DM3MKc9IpN0EX/j7Aw+q
	 KiAh4n+UhAlARgufRurk4lWRT1s0VQfHOTUtQY30=
Date: Sat, 28 Sep 2024 14:35:32 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kees Cook <kees@kernel.org>
Cc: Vegard Nossum <vegard.nossum@oracle.com>, "Eric W. Biederman"
 <ebiederm@xmission.com>, Allen Pais <apais@linux.microsoft.com>, Roman
 Kisel <romank@linux.microsoft.com>, Xiaoming Ni <nixiaoming@huawei.com>,
 Vijay Nag <nagvijay@microsoft.com>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH] coredump: Do not lock during 'comm' reporting
Message-Id: <20240928143532.39559729f9eceee468358abe@linux-foundation.org>
In-Reply-To: <20240928210830.work.307-kees@kernel.org>
References: <20240928210830.work.307-kees@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Sep 2024 14:08:31 -0700 Kees Cook <kees@kernel.org> wrote:

> The 'comm' member will always be NUL terminated,

Why is this?  I thought this is only true if the caller holds task_lock()?

> and this is not
> fast-path, so we can just perform a direct memcpy during a coredump
> instead of potentially deadlocking while holding the task struct lock.
> 

