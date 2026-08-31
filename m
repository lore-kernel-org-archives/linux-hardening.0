Received: from outbound.st.icloud.com (st-2003e-snip4-6.eps.apple.com [57.103.77.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50984414A2B
	for <linux-hardening@vger.kernel.org>; Mon, 31 Aug 2026 13:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.77.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788182248; cv=none; b=QVbA6lf0Ihatu3isE6mGiRaQQy9hpJSebN5TQ89o6ZzRhiZVylNrXVu3yTZeVH16JHYHpoMNlEHBUZjSgZSxEYyh9iGes2lYCn3LNHduwNmKRtY+9UZsVilelg3VVK2T5xS+K+y2FvQTQE//TOLpoXMHWYPSJAOCa0UXawXrimE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788182248; c=relaxed/simple;
	bh=/NXqggHsuDWw6b/862OcbvRPaN5QM214yMR59irur7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uG3RbppQ9LcHdGVw9ZCDNOr8snI0KbhjlWQlP7B8cN/evZyQK/k+S+CRN2ayKmy8KkbGnT5vZ2E7lKsAhv81fAMqlGu3UTzAi+ilfcxY7ugKbAnPL/1itVq3PMQAJPz1PC8pb4Tt28ig2nVaQb22X0LKArNhq8eB5Jhl6nDfYLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com; spf=pass smtp.mailfrom=me.com; dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b=YWoZMdbj; arc=none smtp.client-ip=57.103.77.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=me.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="YWoZMdbj"
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-20-percent-0 (Postfix) with ESMTPS id C82C018000AB;
	Mon, 31 Aug 2026 13:17:24 +0000 (UTC)
X-ICL-RepId: 01a057f7-ad82-7cef-bcb4-8287cc81275c
X-ICL-Out-Info: HUtFAUMHWwJACUgATUQeDx5WFlZNRAJCTQhABkMAWBxBDkkdXwVaEhVdRVUIRRlTHhccRgxFGVswVB0dDlgGEhZdRV4IGQhdHRkKUFAAS1oVVRcOAkIfUB9MFldDRB8cGVoUXBhTRVEfVFhDGUVWaUELTx1dGVscQmRYVwkKBldeWhdeTVoCVk0FSgNfAVsKQwhJAFwAWgpeC0gDVARfH0EUHlYfRQpcXl0NUh9FAnIdXFZQAlpVEgRACFZQXgheH0wc
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai; t=1788182246; x=1790774246; bh=/NXqggHsuDWw6b/862OcbvRPaN5QM214yMR59irur7g=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=YWoZMdbjwCIHeb+zsnvWKlg+V5rJSlhlcqvizPdNk+pUNeoqDDWovVaibmsK/vn/MT48KEsQf11z4uK7xVnhqXZqrryAdzMLSTshMxuvYPA9tp92JSrMLg1t0e+M7r6QDPb+YqzCmx+QyfAfRosq19aEsm49XXCV9B9iy61Wz1vpHbBONYZ4U4XHfWIJnKMS0nE7VEL7TB/WE/+BnQfx4JSBzc80CQCseIcUBJMS/MUyaiEsc9Fuz+mClHOQF0ztNKcWX3rZUP0QclUK9Aa1A1yZ/XMoHVbAafGNzg7FjuFJv2A9oQIjow7VUaYpf8kwQvq8Fgii8eq+aSE3sVQQBQ==
Received: from ncore (unknown [17.156.216.30])
	by p00-icloudmta-asmtp-us-east-1a-20-percent-0 (Postfix) with ESMTPSA id D7F6818001D8;
	Mon, 31 Aug 2026 13:17:22 +0000 (UTC)
From: Ferran Duarri <ferran.duarri@me.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Nicolas Schier <nsc@kernel.org>,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	Ferran Duarri <ferran.duarri@me.com>
Subject: Re: [PATCH] kbuild: ubsan: skip UBSAN for external modules by default
Date: Mon, 31 Aug 2026 15:17:17 +0200
Message-ID: <20260831131718.200934-1-ferran.duarri@me.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821190701.GA3030879@ax162>
References: <20260821190701.GA3030879@ax162>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDExNSBTYWx0ZWRfX+nvHO2Wkl41N
 bYPdAXHv+lue6T+9xE4Zhm+ELlV8yLPYOXl9VfqqGkKTKtYf2AcA74uKX2+mPAVcQ/uS9euE57f
 Rdp0zevF0Xd2uRlBzFth76XIQmGSTkZkI9SAr7cPALaCaLe+y8ENZ6Y4Tk/NF810NJO/xihqdYT
 GhVqidXq6GC8FwIree9NNLNfkL/ChKcEpiPLjGLhzZP84NZZJRnBJwVF1aCptcMESs2MC1UNBlK
 wsxjsdEaddxy7uJ1eQ5oirGvWYVtP7jC+cVspUJrSqR+srY8+sd1xWy13vqWB7KvPQI28w7Jb6S
 OYOfGfuToRY4gDjYeWCOTUnvUU981tC2qojuGSCM/57FuG2V4IivzsAJKCCZ20=
X-Proofpoint-ORIG-GUID: 9j-KgrMVfH6gzULv84ydPs8Z63Ynt-go
X-Proofpoint-GUID: 9j-KgrMVfH6gzULv84ydPs8Z63Ynt-go
X-Authority-Info-Out: v=2.4 cv=ZYcQ98VA c=1 sm=1 tr=0 ts=6a957ee5
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=B9nqV3Rn1-QA:10 a=VkNPw1HP01LnGYTKEx00:22 a=LMDzS8KKjDtqAWibp1EA:9
X-JNJ: AAAAAAAB9S9rmiJ65TXhQlyBQOc9xr0kE/GOC2HQq+H/9qrEj5UQh60/AgfR/+NN8mz6+g/9Y6xJTYxh/U0DxVQToKsDKyI/apjBxOZBoaFFpivFtACALM9t7dpysYGolaQF6x+cy1yjZchQwgqATg+SnHx3m42RiuRH0SoFhCXdtjdM5a8bmgbYQrGEcCZzjCCWYtx7Iqvvj+LSE3PvGThGmNq/zgdfyWQ43lCeAnYEepJeT3pbPKsUgnI8kKxAS50/f8cOsCUE9H3JoZwtMG5GUzvjg1M7UK+q67bxPr9nex1CfyhMia4Fljk0MJqA1zF1y1e6QDlD9rZtrVFSXVrPzIXD/rSZJUhojTtAj6lvYN4T5A8LcmbIPDncPpA+GhG/pT80zY1BToXbzGXSnX/B4gVBHaGgfv/MsxQoIrQU0YDEXLeDqFZPnC3u4ZZ9iKPWtQeekFqXZnoxFKkJuthnJxQHVW0tb5XKyk6gA4Ti2snNIwto358NuYaJItE+nljb6dXq0ZkUQa+z2cOqLp7vuqxcKiTjkexcMstYac+5zdzs1jQkP/ERKB2UJC/uU4Wk26GqRKzPXCnt63tj9TbKLsX2rAVpvn5h48LGCbAwFXxlRttVbJDl9bdRIfwqRtjRXzYkoAbCLnXelKWyDbFd+Kx7K3qk8LxuJm1UWUXjF97mZoUsyHCwa6q8xgEnQbJ7CO2q4CLRLrFDM4WXJkwmBnFVspHhz6ME2hG004QDhMkiQZ5nPUCjuXl38c+Bc09KW6Ssl/d/Vi+YTufZth6GffhmEFDtcoVy1hqV8Geu0R3/DXKXpxOW+EpMRC2oiSlTEQMU4gVsHNvw0eiDPw/Dq7TdD9baMbsXNmzEoIm2ATfaL6/K2cX51YTeK6zPrk0Jkb438kouZQLY4ED7xUYcRxSIC2Z1WlgAJGh3cGrwMB+wewhH2t3Tj+oVdaItsJNEhi7cOhfCSHLP6DcQPtPJ1i2OjgB
 zIZQqlkNbwt6PEW49xKwOttW54V4O2pbPZhDvJ/pHmZ2jckh/kEwOi0ERZ+3AdqNVPlZlK1L/AgEPAGlEMCtPO/5+Xj/lp+OthB5xhEpZSFKUb+RDq8nb/shg9HU6xXgSIs6hZaMJTrYCpU1ih22H9zNWNbgKwjeJXwRBlVLdGv4o0hQpyqikSZdlAZBvNunhnYk/KvPlIQe/YKc7ekk1pLMIT3Eq1QWZuFHqPKtVZqZxDqDQKaiR8GA=

Nathan, Nicolas - fair, and it's the right call: making UBSAN weaker for
everyone to fix one out-of-tree module's problem is a bad trade. Dropping
this, thanks.

Cheers,
Ferran
