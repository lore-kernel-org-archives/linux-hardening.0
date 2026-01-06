Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D348A30FF30;
	Tue,  6 Jan 2026 19:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767729586; cv=none; b=EE6CeiabvrbSpI5pITCdL6d3SoOHKRCvogx52fu+1Sd8gs5JPATV2/rMfuB8tvBKAelEb05Z5Dq55ggXRUg+l1QA9XEA5NODRZz2MLCJvVypwzXvNVU6QMmZcX+HzwW2OmpBNKavE9LSwBWo+N2DzoJuaMDjzy4IjQ2FMFpG6pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767729586; c=relaxed/simple;
	bh=+uMYO8Zcxy/LKS7iUfEqcKI8uYdKCiFIFxLZuU6quyA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A6MgGRLcfpTm36fG+y/b3OPti8mxsz/jvkH+V05JsuqpaxXOiESoW9HG3jT5AKukU74g4KmS809EmqQ34yBf7vZq50+BIBbqQDHKh8WDEqe8ookOUOekfJat3sF0b1ff9usTZDROC1gLRfUGNOen4upqGu4JaBWNJ3BL/ADDSXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qlUBYoDX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qlUBYoDX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6232DC116C6;
	Tue,  6 Jan 2026 19:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767729586;
	bh=+uMYO8Zcxy/LKS7iUfEqcKI8uYdKCiFIFxLZuU6quyA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qlUBYoDX2H5vGWPhhRP5iKMQNMSQFaSgK2LSocZgkXFoNlCCS1a4bXhawNCqOVQR5
	 yNZ9TBZJTZL4PR7RI7Lav2FYx2JrIuv2LqtMgRFIKYbshtc9kxjFpBxTr9ViLP+L1B
	 RJeSQuicpHAl2E5ENTalteggB0l2BuUGJJAuQ71g9uTBWR310CLQCfP1Ap869NQcTV
	 pARBkjDOmpgFQMmF1dOUCRN0CPylEZTIhjwuOgIsut/3FClTe4GqOS6wgDToF0qdqT
	 hCpBJvbmDx7fG+rHQ4SSNRPjfQqH8Vw9S3+uad0AE6x8E3YawazWhfXAvwCEeO8mkW
	 bRny5qLWG86Uw==
From: Kees Cook <kees@kernel.org>
To: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3][next] drm/nouveau: fifo: Avoid -Wflex-array-member-not-at-end warning
Date: Tue,  6 Jan 2026 11:59:43 -0800
Message-Id: <176772957954.1530485.4582284327428826161.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aJ17oxJYcqqr3946@kspp>
References: <aJ17oxJYcqqr3946@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 14 Aug 2025 15:01:07 +0900, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Use the new TRAILING_OVERLAP() helper to fix the following warning:
> 
> drivers/gpu/drm/nouveau/nvif/fifo.c:29:42: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] drm/nouveau: fifo: Avoid -Wflex-array-member-not-at-end warning
      https://git.kernel.org/kees/c/2d4909bae919

Take care,

-- 
Kees Cook

