Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF1535963;
	Wed, 18 Jun 2025 21:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750282267; cv=none; b=iTneEUZAXDQn8NKWlfBKuFMQNff5ip4xWG2hMwAKHgbVEw6yztIfRtkbc+4W8Ct8NxeNw0N3DsNTxrPikbHToAbd3wPsCMYh8jvyDY9qHBv0fT3fIYYOMms+zwPys1W+6zvfdtO7NQdBt0u4z536sSbxUPX96kHL7n6icIRZI5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750282267; c=relaxed/simple;
	bh=I9Nz56Ex8SE0uGILxFwoQKJiRJvBIhj6pNl+Bohbq8w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=No8vryVFG7Qe4rZVTworGI5vqjURvFEWwlgIgjuwdNFA7F7jh7rDQM0JPFJvO5KmEE06R+U3nUKhNpA/NE6Nkbrm5mmIHLQ0eXV3ctRzb5+iDfxOFcrGZ0VBhXdp8FhnA9hEAN30cbWdHBgeXVxS7Qh+ccS6GyjHFY2j0gusQpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQs6lloB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQs6lloB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0BDCC4CEE7;
	Wed, 18 Jun 2025 21:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750282266;
	bh=I9Nz56Ex8SE0uGILxFwoQKJiRJvBIhj6pNl+Bohbq8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UQs6lloBlNmWKZrLjnVIFISTCg1wWsST5lP9sN96QDWGmQF+0BbJdV4CD7CNisgm9
	 cvwwyJz1coYPHxCK92t3DkBRxe6A2DJnou2VpMZBBHRt4hfaMzVFI4qGJ5s2UXgLIH
	 CxQDkVoDu+SRvgIv/3yEURqwSuESJtqh1YaBJxy5p8nuNoYaHEthXD2SRWZL1LqVUo
	 KD8af2OX3IdLdsBYZfvbMGCmz3NDbYmkgW75fc2bpnBQ7zsFXeAc3yK/QtxvlRR91M
	 Fnty7s+oplHAl4/yNA9zyPYW6VER+XJ9ThZFaIKZNHqnAefURfa0j7nqZ7MN55Y9Zs
	 NBEnutCCX+kKg==
From: Kees Cook <kees@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] stddef: Introduce TRAILING_OVERLAP() helper macro
Date: Wed, 18 Jun 2025 14:31:04 -0700
Message-Id: <175028226348.3187836.13627549076923248715.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aFG8gEwKXAWWIvX0@kspp>
References: <aFG8gEwKXAWWIvX0@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 17 Jun 2025 13:05:36 -0600, Gustavo A. R. Silva wrote:
> Add new TRAILING_OVERLAP() helper macro to create a union between
> a flexible-array member (FAM) and a set of members that would
> otherwise follow it. This overlays the trailing members onto the
> FAM while preserving the original memory layout.
> 
> 

Applied to for-next/hardening, thanks!

[1/1] stddef: Introduce TRAILING_OVERLAP() helper macro
      https://git.kernel.org/kees/c/29bb79e9dbf1

Take care,

-- 
Kees Cook

