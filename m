Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB7319FA7B
	for <linux-hardening@vger.kernel.org>; Thu,  5 Sep 2024 16:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725555205; cv=none; b=UVO+V6ohiRRa7mDhHl/4q/a7HXwJY9+X0hiM7fqlNGXaokA0xLZzhFGKA6/Kr1qhm2vLMO2p9Qg6ikmsWLN3iVABd/a/P5pEQ1TMNhecHW6yxahVTTB3o4b8oJHogoUoIRB3b0V+I3gMerWX6nt1tJuBiMkjxVxc7Ak81GOEFVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725555205; c=relaxed/simple;
	bh=06IxUJfRmk4viOzOepqhbrR4w/s9L+YyQAFKiKbxDVE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Me28kFR68AZ5y/TAmjN+F4Q3i37NuMbKVQVumy3m6mTesBdaJxKG0OJIUkUZcca+/SPBx2A7yarb+7ssYCtUfwoVWvxJFdKzVW1T0PsXKMRvGl4DxR2rNQBAFAUhcS12fIOAaDQ2vvWm38iUWdZHYMXc7tk0UNADspapBHIHylQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNbgky6O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNbgky6O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0226EC4CEC3;
	Thu,  5 Sep 2024 16:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725555205;
	bh=06IxUJfRmk4viOzOepqhbrR4w/s9L+YyQAFKiKbxDVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oNbgky6OwKEDkpknFORC9vOE3dCWd5OpWbokibvav2l4Yxs0Mj4+3fuDQt5BbPKaJ
	 FKDcS0ojRK5qHJX/IsDJL/q1fz5rbwML1uZfTA6eYKEmCl1lTWFKT57HK2HjQHVJcG
	 BV9DAb7qB2fjDqGXKQHb0BAUEESIKbCvFj4382EdBgX1V1Ou/MBl/vmGe8ySGUqLuf
	 FELzZGOEyEiuR/WbGKUEEWjwq0dVnfq69BNi1JFLc2hce3UUtoVIWxBEqhoWPagCS7
	 xDt1HPABKWooOSbEukQ0v09VNmcrft+R0kSyXG5ii0DhxBuxbJvf9DvLPdLuwkesRo
	 78jBa8IFS/EwA==
From: Kees Cook <kees@kernel.org>
To: andy@kernel.org,
	Hongbo Li <lihongbo22@huawei.com>
Cc: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	chris.zjh@huawei.com
Subject: Re: [PATCH -next v2 0/2] Introduce several opposite string choice helpers
Date: Thu,  5 Sep 2024 09:53:12 -0700
Message-Id: <172555519045.1959528.3550791041539820887.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905092540.2962122-1-lihongbo22@huawei.com>
References: <20240905092540.2962122-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 05 Sep 2024 17:25:38 +0800, Hongbo Li wrote:
> Similar to the exists helper: str_enable_disable/
> str_enabled_disabled/str_on_off/str_yes_no helpers, we can
> add the opposite helpers. That's str_disable_enable,
> str_disabled_enabled, str_off_on and str_no_yes.
> 
> There are more than 10 cases currently (expect
> str_disable_enable now has 3 use cases) exist in the code
> can be replaced with these helper.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/2] lib/string_choices: Introduce several opposite string choice helpers
      https://git.kernel.org/kees/c/c2708ba91c3c
[2/2] lib/string_choices: Add some comments to make more clear for string choices helpers.
      https://git.kernel.org/kees/c/c121d5cc3a99

Take care,

-- 
Kees Cook

