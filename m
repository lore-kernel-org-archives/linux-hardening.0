Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9D213DB88;
	Sun, 22 Sep 2024 02:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726972933; cv=none; b=dwU6PcIJew6PgMxTU5bx8Xq1KEWI9WOTEVqTYN8qvJD6+VBn7VonkBiAaEYhMCzKPWplOEpq9CwlaTvtqTvE4g1aBeccmO5W7oFQ3nHUHQeDqzl+BdL8rykbP5ReEy+WlkUaJ7enVZ5TJFS1Y6kjlBrt4RPSv8XZ0Uxt/t8spSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726972933; c=relaxed/simple;
	bh=F2sRA/waMaVZiogBCpg45s1Yg8jSpVY87MXz2W5LWhk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=G7sHswjrXyD9MHWOQBiRGsKNCwNVjvjHHv1wOERTINU/FmpOA8uoSpMU6kXr0VGYTMUR+vQea1F9gUigJ0P23BnVLySqQfo7V11hd1XrFiDCk93BbCXy482lKO5hwWmhp/irEAEewPGbWiF7AvfvvbwnvT4BSAmj/I+Es+JUREM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PwL5mood; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PwL5mood"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C24C4CEC2;
	Sun, 22 Sep 2024 02:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726972933;
	bh=F2sRA/waMaVZiogBCpg45s1Yg8jSpVY87MXz2W5LWhk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=PwL5moodjftQlhDhVTIBrhaaq1XyE3g8oVWYf/Poal/g8OP09ccV5wGEHHQXYeAWH
	 P2mPFpfb4UTuUcbO6yRr7L2KmZy93Qx7nfEX2sUkLnBVDOoYLg+BXX/HRSLc8xBk+K
	 5Cdl89F5IVTephwz36skmMpwlakldWidNhsWGfocLcwF9qCiJygzqsJglZ71sT+G5R
	 xBo/OkLs1yclRMeS+z+aPEEeknM2VPD8PqmSLT4kGsmrsJfksio5Z3Ajl0WUNl3wuc
	 CunKOMfVThwIK8NP/zDJCLLj2nrB4l0TNxcIOse/NOOb35erffXNv9eNgh1lpaiu88
	 ig3cKe7kcvaPA==
Date: Sat, 21 Sep 2024 19:42:12 -0700
From: Kees Cook <kees@kernel.org>
To: Jason Montleon <jmontleo@redhat.com>, linux-hardening@vger.kernel.org
CC: Linux regressions mailing list <regressions@lists.linux.dev>,
 linux-riscv@lists.infradead.org
Subject: =?US-ASCII?Q?Re=3A_=5BREGRESSION=5D=5BBISECTED=5D_Cannot_boot_?=
 =?US-ASCII?Q?Lichee_Pi_4A_with_FORTIFY=5FSOURCE_enabled?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAJD_bPJes4QhmXY5f63GHV9B9HFkSCoaZjk-qCT2NGS7Q9HODg@mail.gmail.com>
References: <CAJD_bPJes4QhmXY5f63GHV9B9HFkSCoaZjk-qCT2NGS7Q9HODg@mail.gmail.com>
Message-ID: <B2A62C7F-45BA-43E1-975F-5AF0197CD2C3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On September 21, 2024 10:42:11 AM PDT, Jason Montleon <jmontleo@redhat=2Ec=
om> wrote:
>Starting with 6=2E11-rc1 I can no longer boot the Lichee Pi 4A with
>FORTIFY_SOURCE enabled=2E This works on 6=2E10 up to at least 6=2E10=2E11=
=2E
>However, with 6=2E11 I get no output at all from the kernel on the
>serial console with FORTIFY_SOURCE enabled and the system never comes
>online on network or otherwise as far as I can tell=2E
>
>I did a bisect which led to:
>2003e483a81cc235e29f77da3f6b256cb4b348e7
>fortify: Do not special-case 0-sized destinations
>
>If I revert this commit I can once again boot the Lichee Pi 4A with
>FORTIFY_SOURCE enabled=2E
>

Thanks for the report! Are you able to catch what the error log shows? The=
re must be some 0-sized array that snuck by=2E

Can you share your =2Econfig and compiler version?

-Kees

--=20
Kees Cook
