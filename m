Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBCC24E4C6;
	Thu, 15 Oct 2026 01:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792026397; cv=none; b=EUyxhyGYLF6SOy2o7/gOrNF9ht18bN0+qv56RSYw9MG2QYDL2lHCk5dF5hcVNgB0NHZsP4mSeefLNTBSRNXwdoV+i95P48qEtwHevJVC8yINpUFP/Lq6zQgaFOHf8mi5bsOyX5kPniF0Ot1m8lMe1igwqdVnE2+ZB0wHJV9fMLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792026397; c=relaxed/simple;
	bh=R7D9x3vMG42Orai4ZZ8v+sjIulC5EmVG0HLYoApv0zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kDFul22xlq1TiPw/7F+BZG9e5nijZo41A51ANxwZrB99jZLhoyblHvS/jIa66IRztNK6M1jHNVNygkh351EzoK0lgbdn85U5N2Z3GKCfFw0A7FoQL0Qj+O78Bu5WWVzC5zXdpKgYosHQrNPqb7VVIVMIidUiOvJk+95ptlEm2fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8bu9nMn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8bu9nMn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFA421F000C4;
	Thu, 15 Oct 2026 01:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792026395;
	bh=L8HbRdkaDye6xuABN96pSEYca+ujXrprnp52qmFnxvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a8bu9nMndYXJvygmmk2hBCJSEzuGSmXhdZnKllxO2uMNBbHtGR4kMZk8o76EQ5+P6
	 cZmAEkM+47dzM+a+CWElUIkl7Hbgte9OtGVgajHSA+4loId2K/i0IApEOQzSjT77/U
	 N3Sdh8q1Xlb8WnzmxOKzaoJYGDByPm5Eh+dVhBIRh+akU/ELggMLzEBd7R7AWykQpT
	 O9stXHYrqHm3umGOV6W3bOWtWgviMZtBGY0Td6/QMGdLZIpJ00LmoKsnw+eGLG1C0Y
	 57o8ldXLkv7lK4CHpQnumkC/ln2UXUyvvmvQP3g97TaTiCeehxGmyGtS73f5N0V0dv
	 T71nmUdL/tEKA==
From: Kees Cook <kees@kernel.org>
To: Bill Wendling <morbo@google.com>
Cc: Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] overflow: Match arithmetic in both parts of __builtin_choose_expr
Date: Wed, 14 Oct 2026 18:06:33 -0700
Message-ID: <179202639313.3469796.882953895340235726.b4-ty@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261013203146.387344-1-morbo@google.com>
References: <20261013203146.387344-1-morbo@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 13 Oct 2026 20:31:46 +0000, Bill Wendling wrote:
> The two parts of '__builtin_choose_expr()' had different arithmetic
> expressions. This patch corrects it so that both parts calculate:
> 
>   COUNT * sizeof(*MEMBER) + __must_be_array(MEMBER)
> 
> In practice, '__must_be_array' is meant to assert if 'MEMBER' isn't an
> array and return '0' otherwise. However, symmetry is less prone to
> subtle errors (and far more satisfying).
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] overflow: Match arithmetic in both parts of __builtin_choose_expr
      https://git.kernel.org/kees/c/2f70a9b7e9c7

Take care,

-- 
Kees Cook

