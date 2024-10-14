Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF434683;
	Mon, 14 Oct 2024 21:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728940677; cv=none; b=V2aidpCVnbcg1WZp+ZYQfhvKX5hQnJyqil9ByN8CBum5ej+PTgHcNqplUQ0Z2YczvAMySCULMsEqI+IDs2uv+/AMro+63ZZ8/AcQGUld2m8+yGnEK1ny/1Vc1+c5mrBpk5Oj6L4nQY3tQmWZebhkPQO2464FYnnfXNV/rT8oTPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728940677; c=relaxed/simple;
	bh=fkA301EFhqYG3hUeWKpkodiMce8uxLv2tFX4uj6cbOk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YJamwijmKyPmjr6IhBJf2d3eQcsTToRKEAh2oNXeHp7L1tES7bM06S4tk35+1CdQu9hqp8dvqsYEb4B3N/puTZ9/d6Areu0UwwwREhVBrHY9ewr5OFwNk7SqN0Guu1HPtr5MKzuOlIvs/CAJ6Qk9lFmXvQzD0XMpA4ksVebShkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=doARJRaY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="doARJRaY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E98C4CEC3;
	Mon, 14 Oct 2024 21:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728940677;
	bh=fkA301EFhqYG3hUeWKpkodiMce8uxLv2tFX4uj6cbOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=doARJRaYmlM3mH2FxYPQIo4MYZj5hJU1r5RJm9YJEqiSmUt1KuoPGoNM7CH0j3TLk
	 bdidvGG6vIROUwvqJ/iiX1bzrP/7eFHhSGtROzfP3oaQfWaHK0XLy3x7/17XWhVGyI
	 Tk8PuIllr2/oeRaGBHjnsF5x+JDTMnrgSeBisCttE9SUEVR2YQ5ZgUtovvLEaVjSCC
	 noyw+zfe6d+gBU+aSAzawIVzXgprkSk+4slPLyUjKSW2forpUhf0gobUO/MTtIjahb
	 ZOhYVzpZ+IdsprH/ix+NfkU1h+1hAvmPPirci9H7JClhx2BkPTnW+RpXVm4yUGbv43
	 BEwKQjdIz/OUA==
From: Kees Cook <kees@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>
Cc: Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [RESEND PATCH] MAINTAINERS: Add kernel hardening keywords __counted_by{_le|_be}
Date: Mon, 14 Oct 2024 14:17:52 -0700
Message-Id: <172894067003.238908.8297424817395383569.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241007114935.1647-2-thorsten.blum@linux.dev>
References: <20241007114935.1647-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 07 Oct 2024 13:49:36 +0200, Thorsten Blum wrote:
> In addition to __counted_by, also match the keywords __counted_by_le and
> __counted_by_be.
> 
> 

Applied to for-next/hardening, thanks!

[1/1] MAINTAINERS: Add kernel hardening keywords __counted_by{_le|_be}
      https://git.kernel.org/kees/c/0838c9ca0d76

Take care,

-- 
Kees Cook

