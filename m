Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE0521C175;
	Mon,  3 Mar 2025 17:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741022252; cv=none; b=KtMnED4vNyT5W8kWLboU5t/EOV2Xtw8eVc2ukZHXOTArCkCj8OANscJ1lINY/uYv0AA+lL2ht234+rYslMHQ2IdMZe8r7BO+MhyQjehpgYfDrr5V4XKgfF0JXRQD76AVtVG4HplODZEETf4cTpqy90abFWKolSzHKYMOG6zSD4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741022252; c=relaxed/simple;
	bh=79w1X6pyIzGDJm1JHXG17hzw354uAzGwUl3ep4Nij4A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N72w9bmsmPBwUBv9GuGMU5uGndij8Vv6+dOThlPmZRgF1/wTC3baG5gIbPx0dmICj/NU30rmk+yVPQFp3hlMh4r40xZfeqD3vDtuI+e+TTXAnyoh7YOJv8NEoOi4yjElWHhr2lwd5HeqkA/DAQiy89E9u6K4CH2Wg8oKi3NG6Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WmJoVnKD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WmJoVnKD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1565C4CED6;
	Mon,  3 Mar 2025 17:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741022251;
	bh=79w1X6pyIzGDJm1JHXG17hzw354uAzGwUl3ep4Nij4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WmJoVnKD7a5kIqGNAHXry5k3P8avIICo0FIVNfcolPSFkPZXmV+OHRlNmPIUONfvQ
	 xUERjG1fDnpLYZZ6qqcDaE/4ga7f6yPBJzYI2YIK8ldjeKuaIgYJBHSjoBwzyqMWIs
	 G8v7e4/xGnarVjowPscxplZF7XVKWmjdghLFKO+f+SHqWr93Omo7LHTt8ax/wH/iay
	 sOoioa9aGNvw7jYe5ifemNfp48i7ZiH52tqZbYx/7rstIEyChfpBysP3Mql/5V/vyC
	 7zkd0nOvSkdlCsP6R7kwg5+uL3RcQ83u8EM2dzwvtWJ4i4XBNV2U8Q1DoBAYkFf4Rv
	 dlt9c/hco/eNQ==
From: Kees Cook <kees@kernel.org>
To: Andy Shevchenko <andy@kernel.org>,
	R Sundar <prosunofficial@gmail.com>
Cc: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: (subset) [PATCH v2 linux-next 1/2] lib/string_choices: Rearrange functions in sorted order
Date: Mon,  3 Mar 2025 09:17:26 -0800
Message-Id: <174102224389.3197544.6260199272458870850.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119021719.7659-2-prosunofficial@gmail.com>
References: <20241119021719.7659-1-prosunofficial@gmail.com> <20241119021719.7659-2-prosunofficial@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 19 Nov 2024 07:47:18 +0530, R Sundar wrote:
> Rearrange misplaced functions in sorted order.
> 
> 

Applied to for-next/hardening, thanks!

[1/2] lib/string_choices: Rearrange functions in sorted order
      https://git.kernel.org/kees/c/e8cd61e403ea

Take care,

-- 
Kees Cook

