Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF41E33D8;
	Wed, 14 Aug 2024 17:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723654849; cv=none; b=UyiglXebOoP4VCcyqsXMVcYZfmjO2FBR1xjzKsiOb1lsviXVWYDB8oYVq9bLGgcibtn1UoQyimwGb5YNdaq9TfRh04r5FX+9BGMFAeyCVyx0UFkMMK7MQSRuPv7j1YNOFKAu46pE3w9+q8U4Who0idhzwaak5mibWgkaO/QGyTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723654849; c=relaxed/simple;
	bh=wbO7ucUoXvbBcCVpFMs1yHhmKcKeSaruFWxVAtNHZV0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hur3gMNRX/9P3/+ziCLSsSHGYCqzYbO+YYmNviXjPLgmdWHYXo3Z14z0wI4QL4SZ0MdbSMrae/diDSfJNKy1q7/vMrsvFO1TPG6Kq05AV0agB4x+uDmNDolNagC788nVl6ciUakHnCjj6KDmwIspkAN4dcyxM3zYpv46m7XiHYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FsXbUB8V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FsXbUB8V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E575C116B1;
	Wed, 14 Aug 2024 17:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723654849;
	bh=wbO7ucUoXvbBcCVpFMs1yHhmKcKeSaruFWxVAtNHZV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FsXbUB8VFtAetBwRuYuGCoVKoxpVYqgY6o2qHu8JOG3AKt9dmzTpF83knu/kC/C6o
	 BKDOVSEKYXwL3zE7zVqrGxJy7/mmfr3p0QjVCOkoFUJWPFJuLkwFcNGqHCUB6k8EP4
	 QWIr38ZQKo1ECDHjN/FKYfdGK5Q/vhs8P3ZvBYVQOxUx6YSyzOLqSttY/6rSX58i7i
	 7Lz2vbNSVhgg9t03gzjKa0ZGt4Z5dhPWrJcKuwx6cVN8FrGKhNb2j9izeGs3/vF9V0
	 8ExF5/7+RPe0rRQ/f6qLQJAuxyaP5L1PQU8ZmrZNuPQjQtoLUKrCWXRjrKMuREuNnz
	 ABJuj2L+tXrFQ==
From: Kees Cook <kees@kernel.org>
To: akpm@linux-foundation.org,
	jannh@google.com,
	sroettger@google.com,
	adhemerval.zanella@linaro.org,
	ojeda@kernel.org,
	adobriyan@gmail.com,
	Kees Cook <kees@kernel.org>,
	jeffxu@chromium.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	jorgelo@chromium.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 0/1] binfmt_elf: seal address zero
Date: Wed, 14 Aug 2024 09:59:47 -0700
Message-Id: <172365478431.4159848.371478248517217096.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240806214931.2198172-1-jeffxu@google.com>
References: <20240806214931.2198172-1-jeffxu@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 06 Aug 2024 21:49:26 +0000, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>
> 
> In load_elf_binary as part of the execve(),  when the current
> task’s personality has MMAP_PAGE_ZERO set, the kernel allocates
> one page at address 0. According to the comment:
> 
> /* Why this, you ask???  Well SVr4 maps page 0 as read-only,
>     and some applications "depend" upon this behavior.
>     Since we do not have the power to recompile these, we
>      emulate the SVr4 behavior. Sigh. */
> 
> [...]

I added the cover letter details to the commit log and changed pr_warn()
to pr_warn_ratelimited(), but otherwise, looked good.

Applied to for-next/execve, thanks!

[1/1] binfmt_elf: mseal address zero
      https://git.kernel.org/kees/c/44f65d900698

Take care,

-- 
Kees Cook

