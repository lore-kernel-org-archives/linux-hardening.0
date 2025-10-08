Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D46529E109
	for <linux-hardening@vger.kernel.org>; Wed,  8 Oct 2025 03:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759894142; cv=none; b=qh3jzHXHoW6hoRYP0waUI9/lSeyTnypStlvlzDrblP0w9O6E893+e55jSt4MHPtE4fOjRPbW0aA3X2osqz3zjdh1Ol6qcUYlaA1+jJJZgmBmdCD0rPfPBEsoLH+Qa1IRMj8pKIbS9C3PhumNl9AQTv4cuRd45nDDr78uaoIXFhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759894142; c=relaxed/simple;
	bh=X3PtXfwXh3bnh0BV+hO54AmoU/vmXWSCe6+m6M8aaCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=acNBCG1mMrGLYzMib1ZXcQSObZ7xxoP2aC/ECNJHbfzF0iUpRxkHn57AdzxDx8rv5SMm3RgInJe/x6ekeCjEDvQtVSuqASXBwqwSdn+6s2w+jnK/wcdVpLPcDcTJWvmnBaEsiD+ZOfjm8P+7DwjGs0PJRXE7ROBzpqpuwPSJZYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMwuZGXl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMwuZGXl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C1A4C4CEF1;
	Wed,  8 Oct 2025 03:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759894141;
	bh=X3PtXfwXh3bnh0BV+hO54AmoU/vmXWSCe6+m6M8aaCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IMwuZGXlC98zEBLIeTMrDneaSV4l2Si9iuPfoC4E/3Artlc3Anc6ICeZ9/ubnmx/Q
	 WnNQv+CVocBUhhfCqeNJ4n37L3e1LY8OaNegu88/bPohFAWmq/DB2dexJV1IFiB5Cd
	 3fz59nOdwvEzYudcPoMYGADRnEJXkoNjG9CJJ4SUsqaEqvDGke23jpvI2EC8q74jAN
	 OuzOzNNYwIatFV7EdrHYtj3mZfEwlr9tWe1xipphZv+TPh5l/BYUe8NdsYq/nfQ1nA
	 Va8aJxFwKPlAojDH+ef1AgHqpTTwzZwKNQEBz9xmqPjIqg37d0xZlcgPmPotQcQMiS
	 PQMcQzqRjSwSA==
Date: Tue, 7 Oct 2025 20:29:01 -0700
From: Kees Cook <kees@kernel.org>
To: Qing Zhao <qing.zhao@oracle.com>
Cc: Claudiu Zissulescu <claziss@gmail.com>,
	"gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] arc: Add const attribute support for mathematical ARC
 builtins
Message-ID: <202510072026.568651EE@keescook>
References: <20250826042212.work.202-kees@kernel.org>
 <1B081822-82F3-43A1-B3C3-B0B377F50CE6@oracle.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1B081822-82F3-43A1-B3C3-B0B377F50CE6@oracle.com>

On Tue, Oct 07, 2025 at 09:02:21PM +0000, Qing Zhao wrote:
> Hi, Kees,
> 
> I took a look at the patch today. 
> Overall, I think the patch is good and should work well. 

Thanks!

> My major questions are:
> 
> 1. Are the five functions in the current list the only functions in __builtin_arc_*** that 
> have const attribute?  

They are the only ones I can safely assert are const attribute without
doing additional work. I'm sure there are more, but I didn't feel
comfortable marking others.

> 2. In addition to “const” attribute, are there any other important attributes should be added for
> the arc builtins to enable more optimizations?

Again, I'm not sure. But my goal here is to make it possible to add
these going forward if people find stuff to add. Before this patch it
wasn't possible at all -- the infrastructure to do so was missing, so
that's what I wanted to add: the infrastructure and the first user. :)

-- 
Kees Cook
