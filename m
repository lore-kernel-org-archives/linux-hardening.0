Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F722571A5
	for <linux-hardening@vger.kernel.org>; Thu, 23 Oct 2025 15:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761235156; cv=none; b=eMx8PZAr6mOSISpcOtzF+UVmQvhKkqC1OOnSLyNrgfKVbXGeohz9Q4lGmuYAZQd8D7f4fDEHB5z6JYNMhLggRLPLo0fUvpgH7fbAMEMh6Z0DHrNQIr0ete/HbyRSNk00Ky+s9ZwDGQeylWSUdD6UoYNaovZChTZBla+oefYIqjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761235156; c=relaxed/simple;
	bh=IN34FN/3ED8v5YaYy2OzvWVsVz6VZbvyZZb7YeHfphQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CyukGhVHvGBH7bFtmuYlbNoKpwFzbWq/I+yIr/7VA2TKPRYT1HZspK8yfoMqZ8bMr4eTA+wC945+I4Fz9Uke2F0GAtsJu+gVqik+dZtjrVGi5R+XuDbPwx2hCbhIdT6i9o58q/iC0RewTRld0FZAjYVFDq1DesfduJvCq2mySi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p2fHF70X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p2fHF70X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6356C4CEFF;
	Thu, 23 Oct 2025 15:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761235155;
	bh=IN34FN/3ED8v5YaYy2OzvWVsVz6VZbvyZZb7YeHfphQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p2fHF70X9m3adcJveLq/B7G5GLHN34wJmkrWzz/Xqma+BMbtbYw6IocBn04Q0y3N/
	 7Mvl1PZpYXRLmJ5dSUtJr5WeCvRtk9bYdwIfDlQG+zo+nlJJw2nVZRdGB5NAB+Pp4o
	 ATtTe01W/AEOK9bP/9QSBbYWOC7pieTbIAUKvl91OuEfHuPUEWacWD8dIIEsStCPCI
	 xx8oR6Xx/DwWopHGn4N5PvR31pHNLq1v19Y+4C7PWH3ZTQ3JRWTyiQi1+qrly0cGHm
	 W9Y2HM1MkUYK2tkVkX0cNje20MKyaGJGuG0iQ9m6SuwwH9MYLnsPCS7o/2fho4X2TM
	 d5Hu9XlDT8dMg==
From: Kees Cook <kees@kernel.org>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	linux-hardening@vger.kernel.org
Subject: Re: [RESEND PATCH] pstore/ram: Update module parameters from platform data
Date: Thu, 23 Oct 2025 08:59:00 -0700
Message-Id: <176123513678.805341.13041289609817372519.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251023143755.26204-1-tzungbi@kernel.org>
References: <20251023143755.26204-1-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 23 Oct 2025 22:37:55 +0800, Tzung-Bi Shih wrote:
> Update module parameters `mem_type` and `ramoops_ecc` from platform data
> so that they are available through /sys/module/ramoops/parameters/.
> 
> `ramoops_dump_oops` isn't included as it has been deprecated.
> 
> 

Applied to for-next/pstore, thanks, nice catch!

[1/1] pstore/ram: Update module parameters from platform data
      https://git.kernel.org/kees/c/b69255357368

Take care,

-- 
Kees Cook

