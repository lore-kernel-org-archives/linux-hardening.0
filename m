Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C8321D590
	for <linux-hardening@vger.kernel.org>; Mon, 29 Sep 2025 17:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759167864; cv=none; b=akRVjjmqlodQYWHfGO/TXqmzOVGGvjbjXBHLiQzuuNeEqz190fBg7l3wPNlfBIZGJH9oVPqawrM77lr66dXYYTigd6QY1bJ/QZiuTEBFrlKaMEldFu80KkyNAeGZ621wNYQRqJELF7L+h9775wMJT9dTu+UxfRX3wWvKbtMfVHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759167864; c=relaxed/simple;
	bh=Y25ZPS+yMiAHIHwXXqVuK1iZBdEUXnZ+cLLht36dkfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DriBGtnPkE0EqVdMlecE20csCNGIvsw7k/udbkcK+HihYS94oe4DE52+Su60bcFdINVJoHhMuo64EyHyKTN62AQDk2FBftJiZRBMDRN5ZN35hHEvOAaS7tAcamEcfxqp49O0powcK69kY6bYrOdKCV39ZjnBZWsLZRDdcZWEc+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LyAnmDH4; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LyAnmDH4"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-637dc2292cfso2133014d50.3
        for <linux-hardening@vger.kernel.org>; Mon, 29 Sep 2025 10:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759167861; x=1759772661; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2iq1xGli16J7nUmjOGkf2lv1qlOI+tiFZeMK2lYQ+jc=;
        b=LyAnmDH4PsqwIKECCFvpG90yHs6wVmkeO/PeABLjKFiXxJ4+fQatoHg9NM2rcIuhcm
         pPKI2aeIQH+lxP6DeXNfryrJxewFqHbFb+Mc8ah5m/k27nBU1sNx2F7stEqgWk/SXURL
         y3uJNAw/CZTLHx4MmWKbXU1Tb2MaTbYLEDb51SpliA862LcvNZLgjMXGKIyWRE0uqbNF
         C+QXoK23KkXP1gOD2mRu2m1AYR/Oru42j3pqEPDSLcBxhDnMUuU5ffFDgW/CvKxpqMee
         fB7DtDgbOXXzkObwsDzmtFkmxaXpoZ7Y0aiMQbCW9vD9QxpSN74Sb7iJ8M9Pd1v+gey/
         llkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759167861; x=1759772661;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2iq1xGli16J7nUmjOGkf2lv1qlOI+tiFZeMK2lYQ+jc=;
        b=r/52i0oqnWGTYuwGDTmx8b40HzpJOFvQBQKSeREd90HbCKVti6zCQqR5LmzU8GFWAi
         7/8lRY2/PWf+dOd9e2VvQiGO0WN8DozVIK9NDcNkih/Q+Pe1Tfc0o9XtYcwG8/dxMIqH
         PWpcJ9rcaRg8navO+Lg0EHVJ2pBbZeUfhwKjjEhEiQaGbzNXI2JdKzX+j+8PVfHvHkeN
         cZ12L2Sw9Am1PhO0YMO72Lbq8e8fKllEpMYpfAyVmGoiecPL5co9CZIi4fsjhFBu5Szx
         CR5e/lCwJZZ5q0g05+S5WqBbpIZvf5ZwPPg8a8Lu6Kcckop5SmJugyerex5kwbrFS1wa
         XmZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkY5TkefI4IoGnaCbmcUh9m7dYNcDq8vI5Nwq+kqiqDZGlhFl77g3KvgxBv59Kp37xWi3/LgmipnDawyodAjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuVxLWipZHaIvIi74SaQM6FAXtAnea26ieL/Fvax4r+ugYmFXW
	LPxjAsrXPyCtZxyvv+4ClfMOlATr1+6c3erMyWrPEQaDKaed0FoNphPhN/m7SoGE4VmmS7kRVOV
	zncn8tY78me3yQlK+fsqhK4jMvu7BXDA=
X-Gm-Gg: ASbGncvBOYf5nUj9st8HYjx05ARODjauZxvfs6XsHQGMIICCTNW2VaOj4lyGNBb1NF0
	GQO0d1r5oQLkGA2nRQZE4+CEXtUAxt+ngGZd7ffC3fjF/cuXZGtKtrQnSHhHTHKtCZJBvhoLejp
	vqKlMQPgq/5yzhNQR0upNIPdQz9YIE/co2pJJi65mZN5/9GulCfpxr81IkpFXscAunLTEhTsb6b
	ePplsFB
X-Google-Smtp-Source: AGHT+IHD+fud1cqNFyL89ZYpolBKRgySAYj8na2dCzjfyjGhO2C4PNGwPCYLf3yuYC3SlrkRYNBF+8yYs1tNJabNujg=
X-Received: by 2002:a05:690e:1548:20b0:639:2794:341e with SMTP id
 956f58d0204a3-639279435b7mr4583288d50.3.1759167861254; Mon, 29 Sep 2025
 10:44:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926000200.837025-1-jmeneghi@redhat.com> <20250926000200.837025-2-jmeneghi@redhat.com>
In-Reply-To: <20250926000200.837025-2-jmeneghi@redhat.com>
From: Justin Tee <justintee8345@gmail.com>
Date: Mon, 29 Sep 2025 10:44:06 -0700
X-Gm-Features: AS18NWBdrQ2OubyJNBy1xJM3AAOOxCFmeRS_MY6SKBbtmZUo0BgYs_yjSiVtfKo
Message-ID: <CABPRKS_AOnXmG7NAfgsEKLx2Er_WBcR48wCZwxbKLXnv7FPCZQ@mail.gmail.com>
Subject: Re: [PATCH v10 01/11] fc_els: use 'union fc_tlv_desc'
To: John Meneghini <jmeneghi@redhat.com>
Cc: hare@suse.de, kbusch@kernel.org, martin.petersen@oracle.com, 
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, 
	bgurney@redhat.com, axboe@kernel.dk, emilne@redhat.com, gustavoars@kernel.org, 
	hch@lst.de, james.smart@broadcom.com, Justin Tee <justin.tee@broadcom.com>, 
	kees@kernel.org, linux-hardening@vger.kernel.org, njavali@marvell.com, 
	sagi@grimberg.me
Content-Type: text/plain; charset="UTF-8"

Hi John,

Which branch is this patch based on?  include/uapi/scsi/fc/fc_els.h
does not apply cleanly on 6.18/scsi-queue.

Presumably, is this patch based on a branch without?
44b6169ada7f scsi: fc: Avoid -Wflex-array-member-not-at-end warnings

Regards,
Justin
