Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C29B47F797;
	Fri,  9 Oct 2026 09:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791536910; cv=none; b=e1EXJehjbSKKopEy51/OQLKY9KIA/YHVDJD8Ao34SNL8aAK2rXwbpexZ2dChSmfgBXsCnYHkK2mE6kIFlHDRXzExS4x3ftcbLbX4yWRNO0XJSQEtLdvYLwJYVnlJ1kSb/C8YVdqmdhwLHP45wTnA6v0fh+3z14xdM6S1n71KD0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791536910; c=relaxed/simple;
	bh=fnscWvrcAZlzdhwB+Ig824lWGG3qVF7OpaC0fCP4Tks=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=V7q8SkNW9xSF4tfw4WdY6j70CPDbyfyqJ4bTHJorAhZrkT+PcMiAOJs2rZdlepAsTVDjjzrGze6te354AUKcTuG1cyTHTk/nvEXygvQxia+yrvZCvopApZuvzbVYEciOr7IYOYIbup9/yloLyF/8XkyAiGWdvfQC0ByPXW6AFhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQaq2RW1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQaq2RW1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A24F1F000FF;
	Fri,  9 Oct 2026 09:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791536908;
	bh=lfXpsKS9uzWoEofxIKT6Rircy9hnzSKGV+lLHjdsjRg=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=IQaq2RW1qKYYtY9VevG9B698NIuKq/vjzpqqLujFAmcJpgwikxpruycLT3RwoC93M
	 0JSrFCnAdszgGyitl677OOOEjpWAERPkagBvoRQArnz3DmQdqnNomAS48xiLvI3V39
	 esdVsRZklliAemDKCXPGg4HSFQF3XJB7i8LmON5XFS/utgkg2EqtMyo9l5Gk06VQzQ
	 Hf+qV8/3XENaB45w5AVDjDY/68SF4HOrVKqfuC+kEqInBxJropL5Fbb8qAri7+OPRE
	 EX2wN5UXqITtoTKHdF6dzJzCV2zngs5o1Dfkz+cFeU8vP1Jq+Ol5UW7AD8Htc+/uTn
	 rygKooeyrOEVg==
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v1 1/2] kbuild: Mark the kernel image gzip recipes as
 recursive
From: Nicolas Schier <nsc@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, Manuel Ebner <manuelebnerli@mailbox.org>, 
 linux-kbuild@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
In-Reply-To: <20261009062733.3119731-1-kees@kernel.org>
References: <20261009062722.i.253-kees@kernel.org>
 <20261009062733.3119731-1-kees@kernel.org>
Date: Fri, 09 Oct 2026 11:08:14 +0200
Message-Id: <179153689449.290498.7901907548551466768.b4-review@b4>
X-Mailer: b4 0.17-dev-fde28
X-Developer-Signature: v=1; a=openpgp-sha256; l=3111; i=nsc@kernel.org;
 s=20250924; h=from:subject:message-id;
 bh=fnscWvrcAZlzdhwB+Ig824lWGG3qVF7OpaC0fCP4Tks=;
 b=owEBbQKS/ZANAwAKAQdSCnAWJhJpAcsmYgBqyK8BV8SjyVMgQNOjZzXnnYT1FuXeJNlsZSuYq
 1pZ8OUZI5yJAjMEAAEKAB0WIQSHQTenhzckp4G+wsYHUgpwFiYSaQUCasivAQAKCRAHUgpwFiYS
 acmZD/9cTo1J4ou4BJpYyqZKe/LSFarwwKRq3lzsa7lQQN/+1s/jPyauCNrIR1MhTF3lpSCFmF9
 j2TPSFh9XY5b5+XwTnIDIaJvXTb8Yo25HCBgdhMDqJ6xQbuDrun//SuARfZOLsnvo7TtND0m+Sg
 H2PfT+Dd2EBfNwdJMYj/zjgtTA3sZjrVHv4du1EeHVMWkQsmNmVllRYpG6pCYWVDAkzcqcuf1BB
 vbEuqMoHbcFvakoZSUdy7FUlq/sGMY/P5qtTkTtYqpKEsFtLqVw3+KF4p+LF0Sb0gZY6FJKLzTG
 0ZCwj94xhkTYNES/baPZj4hSCeXlbexfRW4OnRRAC9DgG7U5zYZaIrhYkdIDIqgQq2dymdvmTkN
 yreGdaggUyoDs+v826zDE+POVHo/hFPhEwAJQuoUpewfCQgQpTvYGJVmje/uT+75EqY87yq+IJj
 CDZlm5qjGEd5inlNLeTqOPqlVD6Caov7PVViRHg/fI7dvci//9M+MyECQftONlHihV9g+WOc3t5
 EiWd1FaBoKYEdcoRA4nfy6pzVNyX8UDkEgfLU8zFGuJZE00GN50rpmZwy7+/oZ72ZmDOihF2/8l
 bdul5Vdlm0RYqNp4yPcWd+JvKzuw9RVAeDAMfhXWa45eb4LVz13PX2WdFdVgF4ctlGsa5+V/erT
 T8mj25nF45PmzqA==
X-Developer-Key: i=nsc@kernel.org; a=openpgp;
 fpr=18ED52DBE34F860EE9FBC82B7D97093255A0CE7F

> Since commit 48ebe1cbbeb51 ("kbuild: compress the kernel with pigz if
> available"), cmd_gzip runs pigz through scripts/jobserver-exec, which
> takes the job slots make has free. GNU Make passes the jobserver pipe
> only to recipes it treats as recursive, but leaves --jobserver-auth in
> MAKEFLAGS for all of them. The make 4.3 in CentOS Stream 9 also hides
> the pipe in sub-makes (a backport of the fix for GNU Make bug 58232), so
> jobserver-exec cannot open it, runs pigz on one thread, and prints:
> 
>   WARNING: Unable to reopen jobserver read-side pipe: FileNotFoundError(2, 'No such file or directory')
> 
> Mark the gzip recipes as recursive with "+", as commit ecab4115c44cc
> ("kbuild: mark `rustc` (and others) invocations as recursive") did for
> rustc. As with those, "make -n" now runs them.
> 
> Tested ARCH=x86_64 and ARCH=arm64 defconfig with GNU Make 4.3 plus
> CentOS Stream 9's make-4.3-cloexec.patch, GCC 16.2.0, and -j64: without
> this change the warning appears and pigz runs with "-p 1"; with it there
> is no warning, and pigz runs with "-p 54" and "-p 64".
> 
> Reported-by: Paul E. McKenney <paulmck@kernel.org>
> Closes: https://lore.kernel.org/all/0ddb5e5e-f801-444c-aa98-0cfe814a3026@paulmck-laptop/
> Fixes: 48ebe1cbbeb51 ("kbuild: compress the kernel with pigz if available")
> Assisted-by: LLM
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>  arch/alpha/boot/Makefile             | 4 ++--
>  arch/arc/boot/Makefile               | 2 +-
>  arch/arm64/boot/Makefile             | 2 +-
>  arch/microblaze/boot/Makefile        | 2 +-
>  arch/mips/boot/Makefile              | 2 +-
>  arch/nios2/boot/Makefile             | 2 +-
>  arch/parisc/boot/compressed/Makefile | 2 +-
>  arch/riscv/boot/Makefile             | 2 +-
>  arch/s390/boot/Makefile              | 2 +-
>  arch/sh/boot/Makefile                | 2 +-
>  arch/sh/boot/compressed/Makefile     | 2 +-
>  arch/sparc/boot/Makefile             | 4 ++--
>  arch/x86/boot/compressed/Makefile    | 2 +-
>  arch/xtensa/boot/Makefile            | 2 +-
>  14 files changed, 16 insertions(+), 16 deletions(-)

Reviewed-by: Nicolas Schier <n.schier@fritz.com>


Before it gets lost, we should also update the documentation bit that
references $(if_changed,gzip):

diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbuild/makefiles.rst
index 7521cae7d56f..2760717ab7b7 100644
--- a/Documentation/kbuild/makefiles.rst
+++ b/Documentation/kbuild/makefiles.rst
@@ -1452,13 +1452,14 @@ objcopy
   OBJCOPYFLAGS_$@ may be used to set additional options.
 
 gzip
-  Compress target. Use maximum compression to compress target.
+  Compress target. Use maximum compression to compress target. Add '+' prefix
+  to allow parallel gzip compression via pigz (if available).
 
   Example::
 
     #arch/x86/boot/compressed/Makefile
     $(obj)/vmlinux.bin.gz: $(vmlinux.bin.all-y) FORCE
-            $(call if_changed,gzip)
+            +$(call if_changed,gzip)
 
 dtc
   Create flattened device tree blob object suitable for linking


-- 
Nicolas
