Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE93F3128D7;
	Wed, 17 Jun 2026 19:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781724041; cv=none; b=Gcjs23FzTutJx8CTk4B2SAH9ql6IwERLZNjuq+PUrBTZ+P5mEqGblngR76C5lvEGC2+TO8yKUfnVCHgmX2YQet2KoXXys+ZMETTCKZKrU8I6tVMUJuiLB2SeF0AVpgOeW2XCX6lnnC3aaha1lGV/7Kx5ITeBQYOhYdTsMZRAvKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781724041; c=relaxed/simple;
	bh=K3o7xCDc94SFoCYZjF+NaLDsKb6p2BEaDGBcVGqQlhA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K2yw7nOcWcZK32WaRYcK7ivP3iFZE/gmY7/ITRCe+sX4mFetrSnYjSueCa0tnbTjDtQtzMP9iazOiOB1sdEO062C4vm7TAmNu3wcxbI+zNZRvD6eRao/f4XkKrMoEAyQgBm5Jf+fxQyawWV2dejszLno38SoDiX9JOCn3ZxvODI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jhap7zhe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jhap7zhe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0210A1F00A3A;
	Wed, 17 Jun 2026 19:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781724040;
	bh=kYKRSr/IvpA+RYT9yzgltTdevr93olCdXjwPS6zMpDk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=jhap7zheL+/ZMy27T2SkHU+Ra4upqbgn1zoYSnESTFTA77yFMNjxk89Iayn7WbbuZ
	 eWzj+iAbxQfEveA4WzUuXz1L7mpX8HWsxQVFJvnUK4Di2XDDMXfEqhXX63gV8t4VxI
	 hQdX2JxmIyAUXKk6x6fcgYDDDWHclmfFt7nwtAKL7cuOybieAR4sgMDAI9aVI9h2MU
	 efF4YA+EVkwDqP5RDyXKjwEeKgoEnVGx3jBz5IboZmNPKDsT9NRanhqcCtrfOXoNPH
	 b5mqeJx2UB4dQSEaW+FAtFVb9K++41KyeScj5zz60uJz7L5R1dGf4GAmy4njmYrR3E
	 3zEaKIPFd/lFA==
From: Thomas Gleixner <tglx@kernel.org>
To: Michael Kelley <mhklinux@outlook.com>, Enlin Mu <enlin.mu@linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "enlin.mu@unisoc.com" <enlin.mu@unisoc.com>
Cc: "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: RE: [PATCH v2] genirq: Add the entropy pool function to the PPI
 interrupt handler
In-Reply-To: <SN6PR02MB4157A88F6B527040FD217F8DD4E52@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260616100211.3068-1-enlin.mu@linux.dev>
 <SN6PR02MB4157A88F6B527040FD217F8DD4E52@SN6PR02MB4157.namprd02.prod.outlook.com>
Date: Wed, 17 Jun 2026 21:20:37 +0200
Message-ID: <87cxxpc6t6.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jun 16 2026 at 14:27, Michael Kelley wrote:
> From: Enlin Mu <enlin.mu@linux.dev> Sent: Tuesday, June 16, 2026 3:02 AM
>> 
>> Accelerate the entropy pool initialization process.
>> The function handle_irq_event_percpu adds entropy pool
>> initialization, but this logic is missing in the PPI interrupt handler.
>> I think this was simply an accidental omission.
>
> This change has already been made via a patch I submitted. The
> change is in the 7.1 release. See commit fd7400cfcbaa and a
> follow-on fix in commit 512718bbc51b.

You beat me to it.

Reading and following the documented process seems to be overrated....
