Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E2B1EA7C9;
	Fri, 26 Sep 2025 14:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758898776; cv=none; b=ESk8ZfVQ+rGxo3l5t6jZlC17/mKYG0qEawCOAuc6Tzn4rvwZ1hadIX3z9OU7gA1GtuqPh3LZYcLB67AGGVhf14bwFnB4Grg/8rQ50UjI0rzmPq6606NkMihona5CIDyMz+IhhpwB7xmZTw0tr/HEZRQ7T5YFGJfvADpJxGjfxnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758898776; c=relaxed/simple;
	bh=LXAu2pnvqE9GfKVOekmsFUqcnQwGAuCthdxLBtCKXUU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RJeOW+W0+iMnS+P0NFaZYPls10TTATxW4Yta8kaenbJ8iX7TeeXIAOKMnpTeCZDyH7yLUq0QH1RS0SHbiNPltTxQzslyDI1AnhovvoNgjRljoGN+6AqjB0RQlt27KIQSupk1xy/AwETNKbCZFHv2nGmY0QKParXd0oi0+ahlFz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSY7GnSS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSY7GnSS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B852BC4CEF7;
	Fri, 26 Sep 2025 14:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758898776;
	bh=LXAu2pnvqE9GfKVOekmsFUqcnQwGAuCthdxLBtCKXUU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dSY7GnSSILL/vN7Vh+7Q7Crz3PUYPkR5zUwyiYRZlOSVu07gPUZRfPU/+oF3InfNs
	 qJUInerUoouJxGuBtiI2mfhH0DJf8uTc6tGLY9vEm1LAvwZXi9K1MhB7Zl0iDxoXDY
	 hFef34UhKXjKnsvFh3mJGsI3yV9cy4ITCEKpw/rUDv74EprMXN8vuiu2KnjxEd4xoc
	 YpsbMiXvvwqk7fbxmml6WZstrF6PKeiGyevx0llI42MKE0nbPy8NafHQOTpmXWuKFB
	 Xi27lu7ujD9TW5q2bQsxv3vbeYuRwrOY98rkX/dCDNjvEFbs9xN5UrTTgoDLmhZ5mU
	 E1uvCnPt7/Y+w==
From: Daniel Thompson <danielt@kernel.org>
To: Jason Wessel <jason.wessel@windriver.com>, 
 Douglas Anderson <dianders@chromium.org>, 
 "Dr. David Alan Gilbert" <linux@treblig.org>, 
 Zhang Heng <zhangheng@kylinos.cn>, Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-hardening@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250819095915.711085-1-thorsten.blum@linux.dev>
References: <20250819095915.711085-1-thorsten.blum@linux.dev>
Subject: Re: [PATCH v2 1/4] kdb: Replace deprecated strcpy() with memcpy()
 in kdb_strdup()
Message-Id: <175889877450.8040.12478572282164974656.b4-ty@kernel.org>
Date: Fri, 26 Sep 2025 15:59:34 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Tue, 19 Aug 2025 11:59:03 +0200, Thorsten Blum wrote:
> strcpy() is deprecated; use memcpy() instead.
> 
> 

Applied, thanks!

[1/4] kdb: Replace deprecated strcpy() with memcpy() in kdb_strdup()
      commit: d4be3238d9e5f4841e5385cba3d81268c00d9e7d
[2/4] kdb: Replace deprecated strcpy() with memmove() in vkdb_printf()
      commit: 8790cc2940bf9f5ec4d7458b0ea7f94a8acb094f
[3/4] kdb: Replace deprecated strcpy() with memcpy() in parse_grep()
      commit: 5b26f1a3146454a24dbcb8b1cdae5d507f7432e6
[4/4] kdb: Replace deprecated strcpy() with helper function in kdb_defcmd()
      commit: 0c28a23722e03695ae1cbbadde3dd32d75c1cb7f

Best regards,
-- 
Daniel Thompson (RISCstar) <danielt@kernel.org>

