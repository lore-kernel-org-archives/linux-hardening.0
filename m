Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00618188000;
	Sun, 27 Jul 2025 15:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753631454; cv=none; b=dePcx+I9J4QwBpaybwXOKJ4Lym4KGC+eJHcmKObMa4VkddVH6Vdl11u2+TwtmaSo5ePb3tugtQSwvpz/4aGx1edhN7zO2xndHiwfG4/nKAVwhfe2z0USi7X4XZkSapL/gXGlBkI8qe7zt7v6gbM4wb9QiGApV1nvUsTAJ8+THZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753631454; c=relaxed/simple;
	bh=uZqwwGm065LQI7dRLDoIzl+Vlmkbby//l9h+RF0Lp2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MqFXGa/oOb0A/LHnKQuK6UWbd54AWJlNbze/8ZePSSchVipjnj5+9bP5g84Tyo4SOYToCsaOloo6IXkQJ7s0jVNB3GH/h+030Ys5D80jhEWDDK3MjTy8Wj8dOXvPcxzSdn5dRbmg4DdIWL/gDp1BA/Xz0Y2VWbYl1/Ss3kw55Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2LceatE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2LceatE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EAFAC4CEEB;
	Sun, 27 Jul 2025 15:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753631452;
	bh=uZqwwGm065LQI7dRLDoIzl+Vlmkbby//l9h+RF0Lp2Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S2LceatEmCJfPz6s2eLJeN2Up0rKPhct2bBII20Ezt0h8v+B34LL8ys0csF9ccMmx
	 /6Jj77dAysa0Cz5NWbpL0mYvlhuHjicxfphl6BM8IepXDlFif/ir+Qvz+APS6NCvjq
	 gxgq48pxwveOcQGZ0/fl9gCdvUmgem8kUUP+J9MDpqBdQPxWmICpTH2KTeaoBumTlI
	 Iyf8rR1KoR479fTua9NU4eXs2Aj/B2yjVGLI/MeUzxHmZtnRVfD1BgPZFKD6pr2ZFY
	 IOoaFSEeggTKZMtNgUvzSU2ff62jS5UQK/ekUnix27aEBocQ9CL3xPFJREYPmfdbwG
	 34TIFiYkHDQMA==
Date: Sun, 27 Jul 2025 08:50:47 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Youling Tang <tangyouling@kylinos.cn>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	David Disseldorp <ddiss@suse.de>,
	Qun-Wei Lin <qun-wei.lin@mediatek.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] sched/task_stack: Add missing const qualifier to
 end_of_stack()
Message-ID: <20250727155047.GA1183915@ax162>
References: <20250726210641.work.114-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250726210641.work.114-kees@kernel.org>

On Sat, Jul 26, 2025 at 02:06:46PM -0700, Kees Cook wrote:
> Add missing const qualifier to the non-CONFIG_THREAD_INFO_IN_TASK
> version of end_of_stack() to match the CONFIG_THREAD_INFO_IN_TASK
> version. Fixes a warning with CONFIG_KSTACK_ERASE=y on archs that don't
> select THREAD_INFO_IN_TASK (such as LoongArch):
> 
>   error: passing 'const struct task_struct *' to parameter of type 'struct task_struct *' discards qualifiers
> 
> The stackleak_task_low_bound() function correctly uses a const task
> parameter, but the legacy end_of_stack() prototype didn't like that.
> 
> Build tested on loongarch (with CONFIG_KSTACK_ERASE=y) and m68k
> (with CONFIG_DEBUG_STACK_USAGE=y).
> 
> Fixes: a45728fd4120 ("LoongArch: Enable HAVE_ARCH_STACKLEAK")
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Closes: https://lore.kernel.org/all/20250726004313.GA3650901@ax162
> Cc: Youling Tang <tangyouling@kylinos.cn>
> Cc: Huacai Chen <chenhuacai@loongson.cn>
> Signed-off-by: Kees Cook <kees@kernel.org>

Tested-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  include/linux/sched/task_stack.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/sched/task_stack.h b/include/linux/sched/task_stack.h
> index 85c5a6392e02..1fab7e9043a3 100644
> --- a/include/linux/sched/task_stack.h
> +++ b/include/linux/sched/task_stack.h
> @@ -53,7 +53,7 @@ static inline void setup_thread_stack(struct task_struct *p, struct task_struct
>   * When the stack grows up, this is the highest address.
>   * Beyond that position, we corrupt data on the next page.
>   */
> -static inline unsigned long *end_of_stack(struct task_struct *p)
> +static inline unsigned long *end_of_stack(const struct task_struct *p)
>  {
>  #ifdef CONFIG_STACK_GROWSUP
>  	return (unsigned long *)((unsigned long)task_thread_info(p) + THREAD_SIZE) - 1;
> -- 
> 2.34.1
> 
